# 🎮 Base Roblox Game Structure

Organized base structure for developing a game on Roblox game platform using Rojo roblox dev tool and Visual Studio Code code editor.

> **Note:** This repository is *not* a framework. It is a curated folder and configuration layout intended to accelerate development and maintainability. The structure is **work in progress** and remains incomplete.

---

## ✨ Overview

This project provides a clean, service-oriented organization for Roblox game development in Visual Studio Code via Rojo. It aims to separate responsibilities clearly:

* **Services** — server-side game systems and core logic
* **Controllers** — client-side UI, input, and behavior
* **Utils** — shared modules placed in `ReplicatedStorage`

Example scripts are included to demonstrate conventions and expected workflows.

---

## 📂 Project Layout

```
src/
 ├── Services/
 │    └── Services/
 │    └── Controllers/
 │    └── Utils/
 ├── Shared/
 │    └── ...
 ├── Server/
 │    └── ...
 ├── Client/
 │    └── ...
```

**Conventions**

* Keep server-only systems inside `Services/Services/`.
* Client code and UI logic belongs in `Services/Controllers/`.
* Place cross-environment modules in `Services/Utils/`.
* Use descriptive filenames and prefer small, single-responsibility modules.

---

## 🚀 Quick Start

1. **Clone**

```bash
git clone https://github.com/weverton616179/Base-Roblox-Game-Structure.git
cd Base-Roblox-Game-Structure
```

2. **Install Rokit**

Make sure you have Rokit rojo toolkit manager installed, then:

```bash
rokit install
```

3. **Install project dependencies**

```bash
pesde install
```

4. **Serve with Rojo**

```bash
rojo serve
```

Open Roblox Studio and connect to the local Rojo server to sync the workspace.

---

## ❗ Current Status

This repository is **incomplete** and actively evolving. Expect breaking reorganizations and improvements.

---

## 📜 License

Use and adapt freely.

---
