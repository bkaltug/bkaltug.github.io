# bkaltug.github.io — Personal Portfolio

Personal portfolio of **Berkay Altuğ Ustagül** (Electronics & Communications
Engineer), built as a Flutter web app with an animated "Aurora Noir" background.
Live at **https://bkaltug.github.io**.

## Run locally

```sh
flutter pub get
flutter run -d chrome
```

## Where to edit content

All site content lives in data files — no widget code needs touching:

| What | File |
| --- | --- |
| Name, headline, tagline, GitHub/LinkedIn/email links | `lib/data/profile_data.dart` |
| Education, skills, experience | `lib/data/resume_data.dart` |
| Software & hardware project cards | `lib/data/projects_data.dart` |
| Profile photo (square, ≥264px) | `assets/images/profile.jpg` |
| CV served at `/cv.pdf` | `web/cv.pdf` |

The site works before the photo and CV exist: the avatar falls back to "BAU"
initials, and the CV button simply targets the not-yet-uploaded file.

## Deployment

Push to `main` → GitHub Actions (`.github/workflows/deploy.yml`) builds the
web release and deploys it to GitHub Pages → live at
`https://bkaltug.github.io`. One-time setup: repository **Settings → Pages →
Source: GitHub Actions**.

## TODO checklist

Find every in-code placeholder with `grep -rn "TODO(berkay)"`.

- [ ] Add profile photo at `assets/images/profile.jpg`
- [ ] Add CV at `web/cv.pdf`
- [ ] Email address in `lib/data/profile_data.dart` (button hidden until set)
- [ ] LinkedIn URL in `lib/data/profile_data.dart` (button hidden until set)
- [ ] Education years, GPA (optional), senior project line in `lib/data/resume_data.dart`
- [ ] Confirm the seeded skill chips in `lib/data/resume_data.dart`
- [ ] Replace the two placeholder experience entries in `lib/data/resume_data.dart`
- [ ] Replace the placeholder project entries in `lib/data/projects_data.dart`
- [ ] Replace `web/favicon.png` and `web/icons/*` with personal branding
