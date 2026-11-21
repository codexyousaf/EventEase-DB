# EventEase DB – Team Contribution Guide

Welcome to the EventEase DB project!

This guide explains how to use our GitHub repository and contribute your work. No previous GitHub experience is required.

## 1. Understanding the Repository

Our repository contains different folders for different types of work.

- `docs/` – Project documentation, ERD, project scope and design decisions.
- `database/schema/` – SQL scripts for creating database tables.
- `database/data/` – Sample data and INSERT statements.
- `database/procedures/` – Stored procedures.
- `database/triggers/` – Database triggers.
- `database/views/` – SQL views and reports.
- `database/security/` – Database roles and permissions.
- `queries/` – SQL practice and project queries.
- `tests/` – Database testing scripts.
- `screenshots/` – Screenshots of database execution and results.

Always place your files in the appropriate folder.

## 2. Important GitHub Terms

| Term | Simple Meaning |
|---|---|
| Repository | Our shared project workspace. |
| Branch | A separate workspace for developing a task. |
| Commit | Saving a snapshot of your changes. |
| Push | Uploading your commits to GitHub. |
| Pull | Getting the latest changes from GitHub. |
| Pull Request (PR) | Requesting to merge your work into the main project. |
| Merge | Combining approved changes into the main branch. |
| Clone | Downloading the repository to your computer. |

## 3. Getting Started

### Step 1: Install Git

Download Git from https://git-scm.com/downloads

### Step 2: Clone the Repository

Open the repository on GitHub.

1. Click the green **Code** button.
2. Copy the HTTPS repository URL.
3. Open your terminal or VS Code terminal.
4. Run:

```bash
git clone YOUR_REPOSITORY_URL
```

5. Enter the project folder:

```bash
cd EventEase-DB
```

### Step 3: Open the Project

Open the cloned `EventEase-DB` folder in VS Code.

## 4. Working on Your Assigned Task

Before starting, make sure your task has been assigned and you know which files you are responsible for.

### Step 1: Get the Latest Project

```bash
git switch main
git pull origin main
```

### Step 2: Create Your Own Branch

Example:

```bash
git switch -c feature/create-hall-table
```

Use a branch name that describes your task.

### Step 3: Make Your Changes

Create or edit the files assigned to you.

### Step 4: Save Your Changes

```bash
git add .
git commit -m "Create Hall table"
```

### Step 5: Upload Your Branch

```bash
git push -u origin feature/create-hall-table
```

### Step 6: Create a Pull Request

1. Open our repository on GitHub.
2. Click **Compare & pull request**.
3. Set the base branch to `main`.
4. Set the compare branch to your feature branch.
5. Explain what you changed.
6. Submit the Pull Request.

Another team member should review your changes before merging.

## 5. Team Rules

1. Never directly push unfinished work to `main`.
2. Always create a separate branch for your assigned task.
3. Do not work on the same file as another member without coordinating.
4. Use meaningful file names and commit messages.
5. Pull the latest changes before starting new work.
6. Test your SQL scripts before creating a Pull Request.
7. Discuss changes to shared database structures with the team.
8. Never commit passwords, API keys or other private credentials.

## 6. Important

If you are confused about Git, GitHub, branches, commits or Pull Requests, ask the team before making changes to the main branch.

**Our goal is to build EventEase DB collaboratively while keeping our repository organized and stable.**
