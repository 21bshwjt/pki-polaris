# 📝 Changelog

All notable changes to **PKI Polaris** are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). The project has no tagged releases, so versions below are milestones reconstructed from the git history.

## [Unreleased]

### 📚 Documentation
- Rewrote `README.md`: badges, table of contents, features grid, Mermaid architecture diagram, step-by-step setup, endpoint table, troubleshooting table and project tree.
- Added this `CHANGELOG.md`.
- No PowerShell (`.ps1`) files were changed.

## [1.3.0] - 2022-03-13

### ✨ Added
- `mermaid.md` architecture diagram (Polaris → Routes → SubRoutes / APICache → Endpoints → Users).
- `Screenshots/diagram.PNG` and the `Screenshots/pki.png` logo.

### 🔧 Changed
- Removed extra whitespace in `gMSA/Create_API_Svc.ps1`.
- `.gitignore` updated to ignore `**/Logs` and `*.log`.
- README updates (merged from `dev`, PR #1).

## [1.2.0] - 2022-01-16

### ✨ Added
- `/json_payload` route (`routes/json_payload.ps1`, `subroutes/json_payload.ps1`): returns the certificate cache as `application/json`.
- `.gitignore` and `.gitattributes`.

### 🔧 Changed
- `mainpol.ps1` loads the `/json_payload` route.
- `subroutes/certexpiry.ps1` and `subroutes/domaincontroller.ps1` paging set to 25 / 50 rows (2022-02-10).

## [1.1.0] - 2022-01-02

### ✨ Added
- `/domaincontroller` route: live list of domain controllers (name, IP, OS version, site).
- `/employees` sample PSWriteHTML page backed by `apicache/employees.json`.
- `enable_ssl/mainpol.ps1`: HTTPS on TCP 443 using a certificate selected by Friendly name.
- `htmls/denied.html` and AD security group access control (`$Request.User.IsInRole`).
- `htmls/home.html` home page.
- GitHub Pages site (`_config.yml`, `jekyll-theme-leap-day`).

### 🔧 Changed
- `mainpol.ps1`: transcript logging to `C:\WebApi\Logs`, Windows Integrated Authentication, port 81.
- `build-apicache/certexpiry_cachebuilt.ps1`: template OID mapping to friendly names.
- Certificate expiry dashboard rebuilt with PSWriteHTML conditional formatting and auto-refresh.

### 🗑 Removed
- Committed log files, `css.ps1`, `ca.SQLite` and `certexpiry-example01.ps1`.

## [1.0.0] - 2020-01-19

### ✨ Added
- First release: Polaris web API with a certificate expiry dashboard.
- `build-apicache/certexpiry_cachebuilt.ps1`: reads issued certificates from the Microsoft CA and writes `apicache/cert.json`.
- `gMSA/Create_API_Svc.ps1`: installs the API as a Windows service with nssm.

[Unreleased]: https://github.com/21bshwjt/pki-polaris/compare/0939a84...HEAD
[1.3.0]: https://github.com/21bshwjt/pki-polaris/commit/0939a84
[1.2.0]: https://github.com/21bshwjt/pki-polaris/commit/0ef7d33
[1.1.0]: https://github.com/21bshwjt/pki-polaris/commit/1244c04
[1.0.0]: https://github.com/21bshwjt/pki-polaris/commit/76d0d37
