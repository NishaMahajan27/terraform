# EC2 Instances using `for_each` with a Map Variable

## 📌 Concept

When you use `for_each` with a **Map**, each resource can have its own  
**unique configuration** — not just a unique name, but different values too.

A Map is a key-value pair collection.  
Terraform iterates over it and creates one resource per key.

---

## 🧠 What Problem Does It Solve?

In real projects, BACKEND, FRONTEND, and DATABASES servers  
don't need the same size/power.

A map lets you say:  
*"Create 3 servers, each with a different instance type"*  
— all in one clean resource block.

---

## 📂 What This Code Does

- Reads a `variable` called `instances` which is a **map**:

```hcl
BACKEND   = "t3.micro"
FRONTEND  = "t3.small"
DATABASES = "c7i-flex.large"
```

- Creates **3 EC2 instances**, each with its own instance type
- Tags each instance using the map key:
  - `vm-BACKEND`   → t3.micro
  - `vm-FRONTEND`  → t3.small
  - `vm-DATABASES` → c7i-flex.large

---

## 💡 Key Concepts

### `each.key` and `each.value`

When iterating over a map, Terraform gives you two things:

| Variable | Meaning | Example |
|----------|---------|---------|
| `each.key` | The key of the current item | `BACKEND` |
| `each.value` | The value of the current item | `t3.micro` |

```hcl
instance_type = each.value       # picks the right size per server
Name          = "vm-${each.key}" # gives a proper name
```

### Why use a Variable?

Putting the map inside a `variable` block instead of hardcoding it in `main.tf`  
keeps your code **clean, reusable, and easy to change** without touching core logic.

---

## 🗂️ Files

| File | Purpose |
|------|---------|
| `provider.tf` | AWS provider configuration |
| `variables.tf` | Map variable defining instance names and types |
| `main.tf` | EC2 resource block using for_each with the map variable |

---

## ▶️ How to Run

```bash
terraform init
terraform plan
terraform apply
```

---

## 🔁 count vs for_each — Quick Comparison

| Feature | `count` | `for_each` (set) | `for_each` (map) |
|---------|---------|-----------------|-----------------|
| Input type | Number | Set of strings | Key-value map |
| Identifier | Index (0,1,2) | String key | String key |
| Same config? | Yes | Yes | No — each can differ |
| Best for | Identical resources | Named identical resources | Named + different configs |
