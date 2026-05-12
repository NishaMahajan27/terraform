# EC2 Instances using `for_each` with a Set

## 📌 Concept

`for_each` is a meta-argument in Terraform that lets you create **multiple resources 
from a collection** — giving each resource its own identity.

When used with a **Set** (a list of unique string values),  
Terraform creates one resource per item in that set.

---

## 🧠 What Problem Does It Solve?

Unlike `count` (which uses numbers 0, 1, 2...),  
`for_each` with a set uses **meaningful names** as identifiers.

This makes your infrastructure easier to read, manage, and reference.

---

## 📂 What This Code Does

- Creates **3 EC2 instances** from a set of 3 string values:
  - `BACKEND`
  - `FRONTEND`
  - `DATABASES`
- All 3 use the same instance type (`t3.micro`)
- Apache (`httpd`) is installed on all via `user_data`
- Each instance is tagged with its role name using `each.key`:
  - `env-BACKEND`
  - `env-FRONTEND`
  - `env-DATABASES`

---

## 💡 Key Concept — `each.key`

When iterating over a set, Terraform gives you `each.key`  
which holds the current string value from the set.

```hcl
for_each = toset(["BACKEND", "FRONTEND", "DATABASES"])

tags = {
  Name = "env-${each.key}"   # → env-BACKEND, env-FRONTEND, env-DATABASES
}
```

> `toset()` converts a list into a set — required because  
> `for_each` only accepts sets or maps, not plain lists.

---

## 🗂️ Files

| File | Purpose |
|------|---------|
| `provider.tf` | AWS provider configuration |
| `main.tf` | EC2 resource block using for_each with a set |

---

## ▶️ How to Run

```bash
terraform init
terraform plan
terraform apply
```

---

## ⚠️ Important Note

All 3 instances here use the **same instance type**.  
If you want **different instance types per environment** — use `for_each` with a Map.  
See the `ec2-foreach-map` example for that.
