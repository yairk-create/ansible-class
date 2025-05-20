# Ansible Practice Project

## 📋 Project Overview

This repository provides a structured learning environment for mastering fundamental Ansible automation concepts. The project focuses on practical implementation of core Ansible modules within realistic infrastructure scenarios.

## 🔑 Key Learning Objectives

This project will help you develop proficiency with:

- **Configuration Management** using Ansible's powerful `copy` module
- **Command Execution** through the versatile `shell` module
- **Infrastructure Organization** via inventory definition and configuration
- **Playbook Development** following industry best practices

## 📂 Repository Structure

```
ansible-practice/
├── 03_playbooks/
│   └── 05_summary_practice/  # Primary working directory containing:
│       ├── playbook.yaml     # Main Ansible playbook
│       ├── inventory/        # Target system definitions
│       └── files/            # Supporting scripts and configurations
└── 99_misc/
    └── setup/                # Environment bootstrapping resources
```

The primary learning materials are located in the `05_summary_practice` directory, where you'll find comprehensive examples illustrating Ansible's capabilities.

## 🛠️ Technical Requirements

Before beginning, please ensure your environment meets these prerequisites:

- **Docker Engine** (version 20.10+) for containerized infrastructure
- **Active Internet Connection** for repository access and dependency installation
- **Bash-compatible Shell** for running helper scripts

## 🚀 Getting Started

Follow these steps to initialize your learning environment:

```bash
# Clone this repository to your local system
git clone https://github.com/yair-create/ansible-practice.git

# Navigate to the practice environment
cd ansible-practice/05_summary_practice/files

# Initialize the containerized lab environment
bash set.sh
```

Upon successful execution, you'll have a fully functioning Ansible control node with target systems ready for configuration management exercises.

## 📊 Validation

After running the provided scripts, verify your environment by examining the Docker containers and executing a simple Ansible command:

```bash
# Verify container status
docker ps

# Test Ansible connectivity
docker exec docker-ansible-host-1 ansible all -m ping
```

## 📚 Additional Resources

- Project repository: [https://gitlab.com/vaiolabs-io/ansible-shallow-dive](https://gitlab.com/vaiolabs-io/ansible-shallow-dive)
- Official Ansible documentation: [https://docs.ansible.com/](https://docs.ansible.com/)

## 📝 License

This project is distributed under the MIT License. See the [LICENSE](https://github.com/yairk-create/ansible-class/blob/main/LICENSE) file for detailed terms and conditions.
