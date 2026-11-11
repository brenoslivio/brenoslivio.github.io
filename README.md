# breno.science

My academic website: <https://breno.science>. Contact: <breno@breno.science>.

GitHub Actions builds the site and both Typst CVs on pull requests and pushes to
`main`. Successful builds on `main` deploy to GitHub Pages. PDF downloads use
SHA-256 prefixes generated in CI; generated PDFs and hashed HTML are deployment
artifacts, not committed source files.

See [the CV guide](capybara/README.md) for editing, previews, and build details.
