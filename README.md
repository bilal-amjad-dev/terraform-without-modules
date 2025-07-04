# terraform-without-modules

### Structure:

```bash
.
├── main.tf             
├── variables.tf        
├── terraform.tfvars    
└── modules/            
    └── your_module_name/ 
        ├── main.tf       
        └── variables.tf  
```

Here, I want to write something related to **modules**:

**The variable.tf that is in module directory, we only declare variable (and write type).**


**In terraform.tfvars , we initialize variable.**


**In main.tf, we tell in module block; for this, we have choosen this variable name.** 






