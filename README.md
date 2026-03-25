# ArtSphere Gallery Database Project

A full-stack art gallery management system built with Flask (Python), MySQL, and a custom `ArtSphere` aesthetic frontend.

## Features

- CRUD for artists, artworks, categories, customers, and purchases
- Database schema from `database.sql`
- Bootstrap-like responsive theme styled with custom CSS
- MySQL integration via SQLAlchemy + PyMySQL
- Local storage seed and dynamic gallery behavior
- GitHub repository: https://github.com/Jivesh-2231/Art_Gallery_Database_Project

## Prerequisites

- Python 3.10+ (works with 3.13)
- MySQL 8.0 Local instance
- Git (for repository operations)

## Setup

1. Clone repository:
   ```bash
   git clone https://github.com/Jivesh-2231/Art_Gallery_Database_Project.git
   cd Art_Gallery_Database_Project
   ```

2. Create virtual environment (recommended):
   ```bash
   python -m venv venv
   .\venv\Scripts\activate   # Windows
   source venv/bin/activate   # macOS/Linux
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Configure database:
   - Edit `.env` if needed
   - Ensure database URI matches:
     `mysql+pymysql://root:DBMSisshit@localhost/art_gallery`

5. Create the database and tables:
   ```bash
   "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -pDBMSisshit < database.sql
   ```

## Run

```bash
python app.py
```

Open: `http://127.0.0.1:5000/`

## Project Structure

- `app.py` — Flask app + routes + models
- `config.py` — database + secret settings
- `database.sql` — MySQL schema + seed data
- `templates/` — HTML templates
- `static/css/style.css` — custom ArtSphere design
- `.env` — local config (defined DB URI + secret key)

## Notes

- If MySQL command is not found, use the full path to `mysql.exe`.
- This project stores records in the MySQL database, not just in-memory.
- You can set up a .gitignore for sensitive files (e.g., .env).

## Contribution

1. Fork
2. Create branch
3. Commit
4. Push and create PR

## License

MIT
