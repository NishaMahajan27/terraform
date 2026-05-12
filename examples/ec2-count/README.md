# EC2 Instances using `count` Meta-Argument

## 📌 Concept

In Terraform, when you want to create **multiple identical resources**, 
instead of writing the same block again and again, you use the `count` meta-argument.

`count` tells Terraform — *"create this resource N number of times"*

---

## 🧠 What Problem Does It Solve?

Without `count`, if you need 2 servers, you write 2 full resource blocks.  
With `count = 2`, Terraform handles it in one block automatically.

---

## 📂 What This Code Does

- Creates **2 EC2 instances** on AWS (region: `eu-north-1`)
- Both use the same AMI and instance type (`t3.micro`)
- Apache (`httpd`) is auto-installed via `user_data` script on both
- Each server is tagged uniquely using `count.index`:
  - `server-0`
  - `server-1`

---

## 💡 Key Concept — `count.index`

When you use `count`, Terraform gives each instance an index starting from `0`.  
You can use `count.index` to make each resource unique — like naming them differently.

```hcl
tags = {
  Name = "server-${count.index}"   # → server-0, server-1
}
```

---

## 🗂️ Files

| File | Purpose |
|------|---------|
| `provider.tf` | AWS provider configuration |
| `main.tf` | EC2 resource block using count |

---

## ▶️ How to Run

```bash
terraform init
terraform plan
terraform apply
```

---

## ⚠️ Important Note

`count` is best when all resources are **identical**.  
If you need different names, types, or configs per resource — use `for_each` instead.
