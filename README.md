# Immmahacker
This is a Red team infrastructure deployment, the intention is the minimize reset time between rebuilds and ensure that the deployments are clean. 

How to Use

    Save the script as deploy_all.sh

    Make it executable: chmod +x deploy_all.sh

    Run it: ./deploy_all.sh

The script will:

    Detect your username.
    Create all required folders.
    Drop the correct docker-compose.yml in each tool’s directory.
    Spin up each container.

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
    ├── docker-compose.yml
    └── config/
