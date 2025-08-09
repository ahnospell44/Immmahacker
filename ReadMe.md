 How to Use
1. Save the script as deploy_all.sh

2. Make it executable: chmod +x deploy_all.sh

3. Run it:  ./deploy_all.sh

  The script will:
-  Detect your username.
-  Create all required folders.
-  Drop the correct docker-compose.yml in each tool’s directory.
-  Spin up each container.

💡 Advantages of this approach:

    No hardcoding of usernames — works for whoever runs it.

    Separation of projects — each tool is self-contained with configs.

    Persistence — configs survive container restarts.

    One-command deployment — easy to re-run or modify.

Folder Layout (Auto-created by script)

/home/<your_username>/RedTeamTools/
│
├── evilnginx/
│   ├── docker-compose.yml
│   ├── config/
│   └── phishlets/
│
├── pwndrop/
│   ├── docker-compose.yml
│   └── config/
│
└── gophish/
    ├── docker-compos
