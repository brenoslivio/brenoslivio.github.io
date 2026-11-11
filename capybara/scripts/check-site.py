"""Check the deployment artifact's PDF hashes and migrated public metadata."""

import hashlib
from html.parser import HTMLParser
import json
from pathlib import Path
import re
import sys
import xml.etree.ElementTree as ET


class Page(HTMLParser):
    def __init__(self):
        super().__init__()
        self.links = []
        self.canonicals = []

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if tag == "a":
            self.links.append(attrs.get("href", ""))
        if tag == "link" and attrs.get("rel") == "canonical":
            self.canonicals.append(attrs.get("href", ""))


def check(site):
    versions = json.loads((site / "capybara/cv-versions.json").read_text())
    for key in ("full", "short", "embedded"):
        assert re.fullmatch(r"[0-9a-f]{16}", versions[key]), f"Invalid {key} hash"
    downloads = {}
    for key, name in (("full", "cv"), ("short", "cv-short")):
        pdf = (site / f"capybara/{name}.pdf").read_bytes()
        assert pdf.startswith(b"%PDF-"), f"Invalid {name} PDF"
        digest = hashlib.sha256(pdf).hexdigest()[:16]
        assert versions[key] == digest, f"Incorrect {name} hash"
        downloads[f"/capybara/{name}.pdf"] = digest

    for route in ("", "works/", "events/", "faq/"):
        path = site / route / "index.html"
        content = path.read_text()
        assert "https://brenoslivio.github.io" not in content, path
        assert "brenoslivio@pm.me" not in content, path
        page = Page()
        page.feed(content)
        assert page.canonicals == [f"https://breno.science/{route}"], path
        assert "mailto:breno@breno.science" in page.links, path
        cv_links = 0
        for href in page.links:
            target = href.split("?", 1)[0].split("#", 1)[0]
            if target in downloads:
                assert href == f"{target}?v={downloads[target]}", (path, href)
                cv_links += 1
        assert cv_links, f"No CV download on {path}"
        for data in re.findall(
            r'<script type="application/ld\+json">(.*?)</script>', content, re.S
        ):
            json.loads(data)

    assert (site / "CNAME").read_text().strip() == "breno.science"
    assert "Sitemap: https://breno.science/sitemap.xml" in (site / "robots.txt").read_text()
    sitemap = ET.parse(site / "sitemap.xml")
    locations = sitemap.findall(".//{http://www.sitemaps.org/schemas/sitemap/0.9}loc")
    assert {loc.text for loc in locations} == {
        f"https://breno.science/{route}" for route in ("", "works/", "events/", "faq/")
    }
    assert not (site / "capybara/src").exists(), "CV sources leaked into the artifact"
    print("Validated PDF hashes, download links, contact details, and site metadata.")


if __name__ == "__main__":
    check(Path(sys.argv[1]))
