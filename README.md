# AZ 104 Training

- Earlier we used to have network infrastructure like this
- ![alt text](image.png)
- In the olden days for VPN, companies need to purchase a RAS servers, which allowed access into the company network.
- Webservers used to be placed inside the DMZ
- It would be outside the main network but would have an external Firewall to protect it.
- ![alt text](image-1.png)
- VMWare pioneered the concept of elasticity and scalability. We could have just one server and virtualize all other servers on top of it.
- Microsoft used to have Hyper-V or Hypervisor.
- This also allows us to have redundancy.
- ![alt text](image-2.png)

## Concepts of Cloud Services
- The concept of virtualization got us started with Cloud Services.
- Azure has these concepts of IAAS, PAAS, SAAS
- GPO(Group Policy Object) has been replaced by Intune(MDM/MAM) for Microsoft Azure.
- GPOs used to allow us to enable rules, policies on all the on-prem machines. For e.g all machines should have firewall enabled and all the machines should not provide ability to install certain kinds of software.
- ![alt text](image-3.png)
- Companies also go in for hybrid networks, where some resources live on-prem and some resources live on the cloud.
- Microsoft has services to link the on-prem network and cloud network together.
- There is a software called Azure AD Connect, now called Azure Entra Connect to sync the AD domains.
- This would help us to synchronize user accounts between on-prem and cloud. This enables seamless SSO.
- Azure AD Connect requires us to install a server on-prem
- There is a lightweight tool also for this called Azure AD Sync.
- It only works from on-prem to cloud and not the other way round.
- ![alt text](image-4.png)

## Manage Entra Users and Groups
- Go to Azure Entra ID
- Go to the Users blade
- ![alt text](image-5.png)
- ![alt text](image-6.png)
- ![alt text](image-7.png)
- We can also Bulk Insert users into Azure AD using Spreadsheets

### Creating Groups in Azure AD
- We need to make sure our Microsoft Entra ID P2 license in activated
- ![alt text](image-8.png)
- ![alt text](image-9.png)
- ![alt text](image-10.png)
- Groups can be given permissions to resources like OneDrive. 
- The only thing that Groups cannot contain is Devices. It can only contain users.
- Microsoft 365 groups cannot contain devices. It can only contain user accounts.
- We also have a Security Group for pure Azure related services.
- Microsoft 365 services include Teams, Office 365, Yammer etc.
- Security Groups are built for giving rights to things like VMs or DBs
- We can associate devices with Security Groups
- ![alt text](image-11.png)
- Assigned Group: Group type that can be used to add/remove people from that group
- We can also have Group Owners who can add/remove people to that group
- With Premium Azure AD subscription, we can create Dynamic Users and Dynamic Device Groups
- Dynamic Groups use Dynamic Queries
- ![alt text](image-12.png)
- ![alt text](image-13.png)
- ![alt text](image-14.png)
- ![alt text](image-16.png)
- We can create an Assigned Group as:
- ![alt text](image-15.png)

## Manage Licenses in Azure AD
- Azure uses Azure AD for directory services.
- We may need to upgrade our license to Azure AD Premium license
- ![alt text](image-17.png)
- We can manage Licenses in License Blade
- ![alt text](image-18.png)
- ![alt text](image-19.png)
- ![alt text](image-20.png)
- We can also assign licenses to users
- ![alt text](image-21.png)
- User must have a usage location when we try to assign a license to the user

## Create Administrative Units
- In on-prem AD, we used to have Organization Units (OUs) and we can assign users to those OUs. Then we could delegate control over the resources in that unit.
- Administrative units are similar in concept. They allow us to categorize our objects together and then we can delegate control over those objects to certain admins using roles.
- You can think of a company that has offices in different cities.
- ![alt text](image-22.png)
- For this we need atleast Azure AD Premium 1 License
- ![alt text](image-23.png)
- ![alt text](image-24.png)
- We can add users to an Administrator Unit and then we can assign Administrative roles to those users.
- ![alt text](image-25.png)

## Manage User and Group Properties
- We can directly go to the user and the group and edit its properties accordingly.
- Group writeback state is when we are using Azure AD Connect and syncing our Azure AD with our on-prem Active Directory and once it is synced, it writes back to the on prem AD that the operation is done.
- We cannot change the Group Membership type.

## Manage Device Settings and Device Identity
- We can join devices to our Azure AD environment.
- ![alt text](image-26.png)
- ![alt text](image-27.png)
- Once our computer is joined, we go to Azure Portal, we go to Azure AD and if we go to the Devices Blade, we can see our device has already joined.
- ![alt text](image-28.png)

## Configure Self-Service Password Reset(SSPR)
- ![alt text](image-29.png)
- ![alt text](image-30.png)
- ![alt text](image-31.png)
- ![alt text](image-32.png)
- We can also configure the Security Questions
- It is a straightforward feature
- SSPR is by default turned OFF. We need to turn it ON
  

## Manage Azure using command line tools
- In Powershell we follow the verb-noun system
- For e.g to GET, SET, Start etc.
- To go forward use the tab key and go backward press the Shift key also
- Powershell supports piping | 
- In piping output of one command is input of another command
- ![alt text](image-33.png)
```shell
$computername = CLIENT10
Get-EventLog -LogName Security -ComputerName $computername -Newest 10 | Format-List | Out-File C:\Security_Log.txt
```
- We can make use of ISE for debugging and running powershell commands
- To check if we have azure commands installed, we can run this command:
```shell
Get-Command -Noun *az*
```
- Go to website: [powershellgallery.com](https://www.powershellgallery.com/)
- To install Azure Modules use this command
```shell
Install-Module -Name Az -Force -AllowClobber
```
- To connect to Azure use this command:
```shell
Connect-AzAccount

# Get all user commands
Get-Command -Verb get -Noun *user*

# Get all Groups
Get-AzADGroup

# What kind of new commands i can run on the user
Get-Command -Verb new -Noun *user*

# Create a new User
New-AzADUser  
```
- ![alt text](image-34.png)
- AzureADUser is now deprecated
- However to create a new user using AzureADUser use this command
```shell
# Connect to Azure AD
Connect-AzureAD

# Create a password profile
$passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$passwordProfile.Password = "P@ssw0rd123!"
$passwordProfile.ForceChangePasswordNextSignIn = $true

# Create the new Azure AD user
New-AzureADUser -DisplayName "John Doe" `
    -UserPrincipalName "john.doe@yourdomain.onmicrosoft.com" `
    -PasswordProfile $passwordProfile `
    -MailNickName "john.doe" `
    -AccountEnabled $true `
    -GivenName "John" `
    -Surname "Doe" `
    -UsageLocation "US"

```
- We can also use Cloudshell on Azure Portal
- We can also use Azure CLI which is the bash way of doing things
- In the Cloudshell we will use the Azure CLI
- To create a new Azure AD user using Azure CLI use this command:
```shell
# Login
az login

# Create User
az ad user create \
  --display-name "John Doe" \
  --user-principal-name "john.doe@yourdomain.onmicrosoft.com" \
  --password "P@ssw0rd123!" \
  --force-change-password-next-login \
  --mail-nickname "john.doe" \
  --given-name "John" \
  --surname "Doe" \
  --usage-location "US"

```

## Manage Access to Azure Resources
- Roles provide a way to see exactly what rights are being assigned to a user or group.
- We have RBAC: Role Based Access Control
- Privileges are given based on the role in the organization
- RBAC allows us to give privileges or control over our environment.
- We can achieve RBAC with Groups but it is a management nightmare as the system scales up
- In RBAC, rights are given to the role. 
- We can then assign users/identities to the role.
- Identities can have access to more than one role.
- Microsoft encourages principle of Least Privilege.
- Global Administrator Role is the most powerful role in Azure/Microsoft 365
- Microsoft has implemented PIM(Privileged Identity Management) and using this we can create JIT Administration using roles i.e we can create roles that exist for a specific duration(remember SAS tokens)

### Implementing RBAC in Azure
- ![alt text](image-35.png)
- ![alt text](image-36.png)
- ![alt text](image-37.png)
- ![alt text](image-38.png)
- ![alt text](image-39.png)
- ![alt text](image-40.png)
- ![alt text](image-41.png)

### Creating Custom Role in Entra ID
- ![alt text](image-42.png)
- ![alt text](image-43.png)
- ![alt text](image-44.png)
- ![alt text](image-45.png)

### Providing access to Azure Resources by assigning roles at different scopes
- ![alt text](image-46.png)
- Management group is a root hierarchial system which helps us to separate our subscriptions
- Subscriptions allow us to purchase Azure Resources
- Goal of a management group is to break subscription up into groups
- Management groups are not critical for all companies
- ![alt text](image-47.png)
- ![alt text](image-50.png)
- We cannot nest resource groups i.e cannot have resource group under a resource group
- Resource Groups are for grouping resources under a container.

### Interpret Access Assignments
- ![alt text](image-51.png)
- ![alt text](image-52.png)
- ![alt text](image-53.png)
- ![alt text](image-54.png)
- Every resource has an IAM

## Manage Azure Subscriptions and governance
### Configure Management Groups
- It is a way to group together our subscriptions and it is a way to make a group of individuals or individual responsible for a subscription
- ![alt text](image-55.png)
- ![alt text](image-56.png)
### Manage Subscriptions
- Usually associated with a payment method

### Managing Costs by using alerts, budgets and recommendations
- Azure has a calculator to calculate cost of resources based on usage needs
- ![alt text](image-57.png)
- We can also see Cost Analysis for each subscription
- ![alt text](image-58.png)
- We can also set Budgets
- ![alt text](image-59.png)
- We can also create Action Groups to trigger notifications if budgets exceed a certain threshold.

### Managing Resource Groups
- Resource Groups cannot be nested
- They can contain all kinds of resources
- Resource Groups have to be associated with a subscription
- Resource Groups can include resources from a different region also
- We can also review Cost Analysis and Alerts involving just the resource group also

### Apply and Manage Tags to Resources
- Resource Groups can be Tagged and individual resources can be tagged
- ![alt text](image-60.png)
- Values are optional
- Names allow us to search by Tags
- ![alt text](image-61.png)
- Think of it in terms of budgeting, for e.g a billing dept might add billing code tags and have a value associated with it. 
- ![alt text](image-62.png)

### Configure and Manage Azure Policy
- In On prem AD world, we had GPO(Group Policy Objects)
- In Azure, we have Azure Policies.
- Azure Policies allow us to control certain things, restrict certain things and then we can verify compliance as well.
- Not only is Microsoft creating policies, developers are also creating policies using JSON
- Say we have a Resource Group in East US and storage account in West US
- We want to create a policy on Resoure Group that allows us to add only resources from East US
- ![alt text](image-63.png)
- ![alt text](image-64.png)
- We can either assign a policy or a policy initiative.
- Policy is a single thing, initiative is a group of policies.
- Initiative is like GPO.
- ![alt text](image-65.png)
- We can view the policy definitions as well
- ![alt text](image-66.png)
- We can build our own policies using JSON
- ![alt text](image-67.png)
- ![alt text](image-68.png)
- We can duplicate policy definitions and create our own policy definitions
- We can assign policy directly to resource group
- ![alt text](image-69.png)
- We need to specify parameters
- ![alt text](image-71.png)
- ![alt text](image-72.png)
- Some policies can auto-remediate i.e if a policy violation occurs, the policy can auto-remediate i.e change the text of the location we are trying to assign a resource. However, this current policy doesnot support remediation
- ![alt text](image-73.png)
- Once we have created a policy, it will take some time for the policy compliance to show up.
- If we try to create a storage account belonging to west-us in east-us Resource Group, it will show us an error message.
- ![alt text](image-74.png)

### Configure Resource Locks
- ![alt text](image-75.png)
- Lock Types can be Read-Only or Delete
- ![alt text](image-76.png)
- ![alt text](image-77.png)

## Configuring Access to Storage
- ![alt text](image-78.png)
- ![alt text](image-79.png)
- Storage Accounts use web-based names
- ![alt text](image-80.png)
- ![alt text](image-81.png)
- ![alt text](image-82.png)
- Azure DNS Zone Endpoints use sub-domain names
- Allows Azure to support lot more storage account names
- ![alt text](image-83.png)

## Create and Configure a Storage Account
- ![alt text](image-84.png)
- ![alt text](image-85.png)
- ![alt text](image-86.png)
- ![alt text](image-87.png)
- ![alt text](image-88.png)
- Blobs are a good option to store web-based traffic like audio/video,images,text etc.
- File Shares take the place of a file server
- File Shares support SMB(Server Message Block) and NFS file system.
- ![alt text](image-89.png)


### Configure Azure Storage Firewalls and Virtual Networks
- We can interact with storage account through an endpoint:
- ![alt text](image-90.png)
- We can use custom DNS names as well
- ![alt text](image-91.png)
- ![alt text](image-93.png)
- ![alt text](image-94.png)
- In Microsoft Network Routing, data will enter the microsoft azure cloud network and egress from the closest microsoft cloud network to the destination. We can take speed of microsoft high speed fiber networking and they can route the traffic really fast, but it costs money to do so. 
- An alternative to above is to use Internet Routing.
- ![alt text](image-95.png)

### Configure Azure AD authentication for a Storage Account
- ![alt text](image-96.png)
- ![alt text](image-97.png)
- ![alt text](image-98.png)
- ![alt text](image-99.png)
- ![alt text](image-100.png)
- ![alt text](image-101.png)
- ![alt text](image-102.png)
- ![alt text](image-103.png)
- Here Larry will have permissions only if the container has the word backup in it
- So we set access based on conditions

### Manage Access Keys
- We dont have web server put in credentials every time the user accesses the storage account
- So we use access keys
- ![alt text](image-104.png)

### Using Shared Access Signatures
- For temporary access we use SAS tokens
- These tokens can be generated on the fly.
- ![alt text](image-105.png)
- ![alt text](image-106.png)
- ![alt text](image-107.png)
- ![alt text](image-108.png)
- ![alt text](image-109.png)
- ![alt text](image-110.png)
- Notice that we have a signature query string
- If we modify anything in the URL it will not work, because the signature ensures integrity.

### Configure Stored Access Policies
- We want to decide when certain things will expire.
- ![alt text](image-111.png)
- ![alt text](image-112.png)
- ![alt text](image-113.png)
- We can set SAS tokens even at the container level.

## Configure and Manage Storage Accounts
- Lets say we want to upload 500TB data from on-prem to storage account. 
- Simple uploading it may not be feasible.
- Azure allows us to send us hard-drives to their data center.
- If we want to export large amount of data out of Azure, we can also get Azure to send out a hard-drive.
- We can use Azure Data Box
- ![alt text](image-114.png)
- ![alt text](image-115.png)
- ![alt text](image-116.png)
- Select Import/Export Job
- ![alt text](image-117.png)
- Microsoft wants to ensure file integrity
- They ensure that using a tool called WAImportExport tool
- It generates a journal file *jrn file
- This file is like a spreadsheet or csv file and has a hash code associated with each file and ensures file integrity.
- Microsoft people can verify the *jrn file and ensure data integrity is maintained.
- ![alt text](image-118.png)

### Understanding Azure Storage Redundancy
- ![alt text](image-119.png)
- We have synchronous and asynchronous replication of data
- Are we replicating data to same region or different regions ?
- ![alt text](image-120.png)
- Data in Azure Storage account is always replicated 3 times in the primary region.
- ![alt text](image-121.png)
- LRS does however protect us from server rack and drive failures by storing data in different fault domains and update domains.
- ![alt text](image-122.png)
- ![alt text](image-123.png)
- ![alt text](image-124.png)
- ![alt text](image-125.png)

### Implementing Azure Storage Redundancy
- ![alt text](image-126.png)
- ![alt text](image-127.png)
- ![alt text](image-128.png)

### Configure Object Replication
- We can replicate data from one storage account to another
- ![alt text](image-129.png)
- ![alt text](image-130.png)
- ![alt text](image-131.png)
- ![alt text](image-132.png)

### Configure Storage Account Encryption
- ![alt text](image-133.png)
- We can have one level of encryption on data and second level of encryption on the infrastructure.
- ![alt text](image-134.png)
- ![alt text](image-135.png)
- ![alt text](image-136.png)
- ![alt text](image-137.png)
- ![alt text](image-138.png)
- Encryption scopes in Azure Storage accounts are a feature that allows you to manage encryption at a granular level, specifically for Blob Storage and Azure Files. They enable you to apply different encryption keys to individual blobs, containers, or file shares within the same storage account, creating secure boundaries for data belonging to different customers or applications.
- Encryption scopes provide fine-grained control over encryption, allowing you to isolate data encryption within a single storage account for multi-tenancy scenarios or to meet specific security requirements.
- ![alt text](image-139.png)

### Manage Data by using Azure Storage Explorer and AzCopy
- Storage Explorer is a downloadable tool
- ![alt text](image-140.png)
- ![alt text](image-142.png)
- ![alt text](image-143.png)
- AzCopy can help us upload large number of files uploaded to Azure Storage Account
- AzCopy needs a SAS token to copy to Azure Storage Account
- ![alt text](image-144.png)
- ![alt text](image-145.png)
- AzCopy requires a source file and a destination

## Configure Azure File Share and Configure Storage Tiers
- ![alt text](image-146.png)
- It is more expensive to use web service based capabilities with FileShares as compared to Blob Containers
- If we need to use SMB protocol which Windows Server use or Windows Client use, then File Shares is a good choice.
- ![alt text](image-147.png)
- ![alt text](image-148.png)
- ![alt text](image-149.png)
- ![alt text](image-150.png)
- ![alt text](image-151.png)
- ![alt text](image-152.png)
- ![alt text](image-153.png)
- Open Windows Powershell ISE
- We cns run this script on the computers of all the people who need to map this drive.
- Most ISPs block port 445. We need VPN or siteTosite VPN to connect or ExpressRoute to connect to this File Share.
- ![alt text](image-154.png)

## Configure Blob Storage
- Blob Storage is geared towards web-services and it supports REST, HTTP, HTTPS
- It doesn't support SMB protocol
- We can create a container and create blobs inside of it
- ![alt text](image-155.png)
- ![alt text](image-156.png)
- ![alt text](image-157.png)
- By configuring immutability policies for blob data, we can prevent our data from being overwrites and deletes.
- Once version level immutability support is enabled, it cannot be disabled.
- We can change access level of a particular blob also
- ![alt text](image-158.png)
- If our access level is private, but there is a SAS token configured, we will still be able to view the blob

### Configure Blob Lifecycle Management
- We have Hot, Cold and Archive Tiers
- ![alt text](image-159.png)
- ![alt text](image-160.png)
- ![alt text](image-162.png)
- ![alt text](image-163.png)
- ![alt text](image-164.png)
- ![alt text](image-165.png)
- Really helps to save some money.

### Configure Blob Versioning
- ![alt text](image-166.png)
- ![alt text](image-167.png)
- ![alt text](image-168.png)
- ![alt text](image-169.png)
- ![alt text](image-170.png)
- ![alt text](image-171.png)
- Sometimes when we open a blob it is in a leased state for a few minutes.
- To force it out of data we can use Break Lease functionality
- ![alt text](image-172.png)
- We can make any previous version as current version for the blob.
- What is difference between blob version and blob snapshot?
- ![alt text](image-173.png)
- Snapshot is created by an application but versions are created automatically when the blob is overwritten


## Automate Deployment of Resources using ARM templates or Azure Bicep files
- To implement infrastructure as code for your Azure solutions, use ARM templates.
- ARM templates use declarative syntax.
- ![alt text](image-174.png)
- ARM templates are expressed in JSON
- ![alt text](image-175.png)
- ![alt text](image-176.png)
- ![alt text](image-177.png)
- ARM templates are shareable

### Azure Bicep
- Bicep is a domain-specific language(DSL) that uses declarative syntax to deploy Azure resources. In a Bicep file, you define the infrastructure you want to deploy to Azure, and then use that file throughout the development lifecycle to repeatedly deploy your infrastructure. 
- It ensures resources are deployed in a consistent manner.
- Bicep and ARM templates serve the same purpose but Bicep has a simpler syntax.
- ![alt text](image-178.png)
- Bicep has an extension for Visual Studio where intellisense is supported.
- Bicep has its own scripting format.
- Major benefit is its simpler syntax and compact code.

### Modify an ARM template
- Think of an ARM template as a recipe.
- ![alt text](image-179.png)
- ![alt text](image-180.png)
- We usually export an ARM template, modify parameters and deploy it

### Deploy an ARM template
- ![alt text](image-181.png)

### Deploying an Azure Bicep file
- We can create an Azure Bicep file as follows:
```bicep
targetScope = 'subscription'

@description('The Azure region where the resource group will be created.')
param region string = 'eastus'


resource RGDemoBicep 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'RGDemoBicep'
  location: region
  tags: {
    environment: 'demo'
  }
}


```
- We can deploy it as:
```shell
az deployment sub create --location 'East US' --template-file ./main.bicep --parameters region='East US'
```
- We can create a standard load balancer in Azure using Bicep using this link:
- https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.network/internal-loadbalancer-create

- ![alt text](image-182.png)
- Think of VM Extensions as Browser Add-Ons
- They are automatically injected into the VM
- ![alt text](image-183.png)


### Create and Configure a Virtual Machine
- ![alt text](image-184.png)
- ![alt text](image-185.png)
- ![alt text](image-186.png)
- ![alt text](image-187.png)
- ![alt text](image-188.png)
- ![alt text](image-189.png)

### Create a VM using Powershell
- We can easily write a script to generate a virtual machine
```shell
# Step 1: Connect to Azure
Connect-AzAccount

# Step 2: Define variables
$resourceGroupName = "MyResourceGroup"
$location = "EastUS"
$vmName = "MyAzureVM"
$vmSize = "Standard_D2s_v3"
$adminUsername = "azureadmin"
$adminPassword = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($adminUsername, $adminPassword)
$vnetName = "MyVNet"
$subnetName = "MySubnet"
$publicIpName = "MyPublicIP"
$nicName = "MyNIC"

# Step 3: Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location -Force

# Step 4: Create a virtual network and subnet
$subnetConfig = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.0.0/24"
$vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Location $location -Name $vnetName -AddressPrefix "10.0.0.0/16" -Subnet $subnetConfig


# Step 5: Create a public IP address
$publicIp = New-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Location $location -Name $publicIpName -AllocationMethod Dynamic -Sku Basic

# Step 6: Create a network interface
$nic = New-AzNetworkInterface -ResourceGroupName $resourceGroupName -Location $location -Name $nicName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id


# Step 7: Configure the VM
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize
$vmConfig = Set-AzVMOperatingSystem -VM $vmConfig -Windows -ComputerName $vmName -Credential $credential
$vmConfig = Set-AzVMSourceImage -VM $vmConfig -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2019-Datacenter" -Version "latest"
$vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id
$vmConfig = Set-AzVMBootDiagnostic -VM $vmConfig -Disable


# Step 8: Create the VM
New-AzVM -ResourceGroupName $resourceGroupName -Location $location -VM $vmConfig

# Step 9: Verify the VM
Get-AzVM -ResourceGroupName $resourceGroupName -Name $vmName

```
- The script creates a Windows Server 2019 VM. For a different OS, adjust the -PublisherName, -Offer, and -Skus parameters in Set-AzVMSourceImage.
- The VM size (Standard_D2s_v3) is a general-purpose size; choose a size available in your region (check with Get-AzVMSize -Location $location).
- The public IP is dynamic; change to -AllocationMethod Static for a static IP if needed.
- This script does not configure a network security group (NSG). Add one with New-AzNetworkSecurityGroup to control traffic (e.g., allow RDP on port 3389).

### Using Azure Compute Gallery
- The Azure Compute Gallery is a service in Microsoft Azure that allows you to store, manage, and share custom virtual machine (VM) images, container images, and other compute resources across your organization or with external users. It simplifies the process of creating, versioning, and distributing consistent, reusable images for deploying VMs, Azure Virtual Desktop, and other Azure services.
- ![alt text](image-190.png)
- ![alt text](image-191.png)
- ![alt text](image-192.png)
- ![alt text](image-193.png)
- ![alt text](image-194.png)
- ![alt text](image-195.png)
- ![alt text](image-196.png)
- ![alt text](image-197.png)

### Configure Azure Disk Encryption
- ![alt text](image-198.png)
- ![alt text](image-199.png)
- ![alt text](image-200.png)

### Move VMs from one Resource Group to Another
- ![alt text](image-201.png)
- ![alt text](image-202.png)
- ![alt text](image-203.png)


### Manage VM sizes
- ![alt text](image-204.png)
- ![alt text](image-205.png)
- ![alt text](image-206.png)

### Add Data Disks
- ![alt text](image-207.png)
- ![alt text](image-208.png)
- ![alt text](image-209.png)
- ![alt text](image-210.png)
- ![alt text](image-211.png)
- ![alt text](image-212.png)

### Configure VM Network Settings
- ![alt text](image-213.png)
- ![alt text](image-214.png)
- ![alt text](image-215.png)
- ![alt text](image-216.png)
- ![alt text](image-217.png)
- ![alt text](image-218.png)

### Configure VM Availability Options
- ![alt text](image-219.png)
- ![alt text](image-221.png)
- ![alt text](image-220.png)
- ![alt text](image-222.png)
- Availability Set has a fault domain and update domain
- Update domain is how they update the equipment
- Fault Domain is having the same power supply and being on the same rack
- ![alt text](image-223.png)
- In availability sets, we setup the VMs ourselves and keep them in different fault and update domains
- Availability Zone allows us to store the VM in different zones.
- ![alt text](image-224.png)
- ![alt text](image-225.png)


### Deploy and Configure VM Scale Sets
- VMSS are a great feature that Azure gives us, that allows us to essentially use elasticity with our virtual machines and auto load balancing.
- ![alt text](image-226.png)
- ![alt text](image-227.png)
- ![alt text](image-228.png)
- ![alt text](image-229.png)
- ![alt text](image-230.png)
- ![alt text](image-231.png)
- ![alt text](image-232.png)
- ![alt text](image-233.png)
- ![alt text](image-234.png)
- ![alt text](image-235.png)
- ![alt text](image-236.png)
- It shows unhealthy because the webserver is not running and it is running health checks against the specified endpoint in the web-server
- ![alt text](image-237.png)

## Provision and manage Containers in Azure Portal
- ![alt text](image-238.png)
- ![alt text](image-239.png)
- ![alt text](image-240.png)
- ![alt text](image-241.png)
- ![alt text](image-242.png)
- ![alt text](image-243.png)
- ![alt text](image-244.png)

### Azure Container Instances
- ![alt text](image-245.png)

### Understanding Container Groups for ACI
- ![alt text](image-246.png)
- ![alt text](image-247.png)
- ![alt text](image-248.png)
- ![alt text](image-249.png)
- ![alt text](image-250.png)
- ![alt text](image-251.png)

### Create and Configure an App Service
- ![alt text](image-252.png)
- ![alt text](image-253.png)
- ![alt text](image-254.png)
- ![alt text](image-255.png)
- ![alt text](image-256.png)
- ![alt text](image-257.png)
- ![alt text](image-258.png)
- ![alt text](image-259.png)
- ![alt text](image-260.png)
- ![alt text](image-261.png)
- ![alt text](image-262.png)
- ![alt text](image-263.png)
- App Service is the application or workload you deploy (e.g., your web app or API).
- App Service Plan is the infrastructure configuration that powers one or more App Services.
- App Service hosts your code and handles runtime execution.
- App Service Plan defines the capacity, performance, and cost of the resources allocated to those apps.
- App Service: This is the fully managed platform (PaaS) for hosting web applications, APIs, and other services like mobile backends or serverless functions. It provides features like auto-scaling, deployment slots, and built-in CI/CD integration. Essentially, it’s the environment where your application runs, and it supports various runtimes (e.g., .NET, Java, Python, Node.js).
- App Service Plan: This defines the underlying compute resources (e.g., CPU, memory, storage) and pricing tier for one or more App Services. It determines the performance, scalability, and features available to the apps hosted within it. For example, a Free, Shared, Basic, Standard, Premium, or Isolated tier dictates things like the number of instances, custom domains, or SSL support.
- One App Service Plan can support multiple App Services, but each App Service is tied to exactly one App Service Plan.
- For example, you could run multiple web apps under a single App Service Plan to share resources and costs.
- App Service settings focus on app-specific configurations like environment variables, connection strings, or runtime stacks.
- App Service Plan settings focus on resource allocation, such as choosing a tier (e.g., Free, Basic, Premium), scaling options (manual or auto), or region.
- ![alt text](image-264.png)
- ![alt text](image-265.png)
- ![alt text](image-266.png)
- ![alt text](image-267.png)
- ![alt text](image-268.png)
- ![alt text](image-269.png)
- ![alt text](image-270.png)
- We can buy digital certificates and associate those certificates to the apps
- ![alt text](image-271.png)
- ![alt text](image-272.png)

### Configure Custom Domain Names
- ![alt text](image-273.png)
- ![alt text](image-274.png)
- ![alt text](image-275.png)
- ![alt text](image-277.png)

### Configure Backups
- ![alt text](image-278.png)
- ![alt text](image-279.png)
- ![alt text](image-280.png)
- ![alt text](image-281.png)

### Configure Networking Settings for App Service
- ![alt text](image-282.png)
- ![alt text](image-283.png)
- ![alt text](image-284.png)
- ![alt text](image-285.png)
- ![alt text](image-286.png)
- ![alt text](image-287.png)
- ![alt text](image-288.png)
- ![alt text](image-289.png)

### Configure Deployment Settings
- ![alt text](image-290.png)
- ![alt text](image-291.png)
- ![alt text](image-292.png)
- ![alt text](image-293.png)
- ![alt text](image-294.png)

### Configure and manage Virtual Networks in Azure
- Vnet is made up of an address space and it will have a range of IP Address, for e.g from 10.1.0.0/16 which is like 65536 addresses.
- Vnet represents whole network and we have subnets inside that virtual network
- Subnet can be 10.1.1.0/24 which is 256 addresses.
- Subnet addresses are a subset of VNet ip addresses.
- All subnets inside the same Vnet can automatically talk to each other
- NSG has ip filtering capability and have traffic filtering capability. We can place NSG in the subnet or we can put it on the Vnet.
- ![alt text](image-295.png)
- In our enterprise we may have several Vnets
- Each project may have its own Vnet
- ![alt text](image-296.png)
- The above is an example of Hub and Spoke Model
- Hub is where all traffic comes in and Spoke Vnets interact with the Hub Vnet
- We may want to connect our on-prem network with Azure
- In that case, we want to ensure our addressing system doesnot interfere with the addressing system used in Azure Subnets
- When we have separate Vnets they don't automatically have routing between them
- So we make use of Vnet peering.
- So all spoke Vnets will talk to the Hub Vnet and Hub Vnet can have Azure Firewall setup to filter incoming traffic
- We can make use of UDRs to direct traffic through something
- We can make use of VPN Gateway to connect an on-premise network to Azure
- To make VPN Gateway work, we need a VPN Concentrator to be installed on the on-premise network
- We can alternatively, use Express Route
- In Express Route, the telecom provider install special hardware inside our on-prem network and then we can use that special hardware to connect directly to the Azure Network using the telecom provider's private network
- It is expensive but it is very fast
- ![alt text](image-297.png)

### Create and Configure Virtual Networks and Subnets
- ![alt text](image-298.png)
- Azure Bastion is a secure way to remote into a virtual machine.
- ![alt text](image-299.png)
- ![alt text](image-300.png)
- We can add multiple Vnets and various subnets inside it.
- ![alt text](image-301.png)
- We can then setup a hub and spoke model.
- ![alt text](image-303.png)

### Creating Vnets with Powershell
- ![alt text](image-304.png)

### Creating and Configuring Vnet Peering
- Creating Vnets and Subnets costs no money but, Vnet peering costs money
- ![alt text](image-305.png)
- ![alt text](image-307.png)
- ![alt text](image-308.png)
- ![alt text](image-309.png)
- ![alt text](image-310.png)

### Configuring private and public IP Addresses
- ![alt text](image-311.png)
- ![alt text](image-312.png)
- ![alt text](image-313.png)
- ![alt text](image-314.png)

### Configure User defined network routes
- What about a scenario when we want to force traffic through a particular subnet
- What if there is a firewall setup inside a Vnet and we want all traffic to go through that firewall
- For this purpose, we use UDRs(User Defined Routes)
- UDRs force traffic through a particular subnet
- ![alt text](image-315.png)
- We will now create a Route Table
- ![alt text](image-316.png)
- ![alt text](image-317.png)
- ![alt text](image-318.png)
- Lets we have a firewall defined at 10.1.10.10 inside the AzureFirewallSubnet of Vnet1
- We can setup a user defined route as follows:
- ![alt text](image-319.png)
- ![alt text](image-320.png)
- Now we will associate subnets to this
- ![alt text](image-321.png)
- ![alt text](image-322.png)

## Configure Secure Access to Virtual Networks
### Create and Configure NSGs and ASGs
- NSG are a set of IP Filter rules
- IP Filtering is where we decide to either allow or block traffic based on a source or a destination
- Do we want to block based on a port or a protocol
- In Azure, the way we control IP Filtering is through a NSG
- NSG can be placed inside a subnet or NIC directly.
- NSGs can be associated with a subnet in a virtual network (VNet). This applies the NSG rules to all resources (e.g., virtual machines, load balancers) within that subnet.
- NSGs can be applied directly to a virtual machine's network interface (NIC). This allows for more granular control over the traffic to and from a specific VM.
- An NSG can be associated with multiple subnets or network interfaces, and a subnet or NIC can have only one NSG associated with it.
- Configuration is done via the Azure Portal, Azure CLI, PowerShell, or ARM templates
- Microsoft recommends us to minimize the number of NSGs
- ASG: Application Security Group. It can be associated to the whole VM. If a VM has lot of NICs, then ASG rules apply to all the NICs
- In Microsoft Azure, an Application Security Group (ASG) is a feature that simplifies network security management by allowing you to group virtual machines (VMs) or network interfaces (NICs) based on their roles, functions, or applications, and then apply network security policies to these groups. ASGs are used in conjunction with Network Security Groups (NSGs) to define fine-grained network security rules without relying on explicit IP addresses.
- ![alt text](image-323.png)
- ![alt text](image-324.png)
- NSG rules are applied in order of priority. Lowest Number has highest priority.
- We can do explicit Deny vs Implicit Deny
- ![alt text](image-325.png)
- ![alt text](image-326.png)
- ![alt text](image-327.png)
- ![alt text](image-328.png)
- We can apply NSG to multiple Subnets or NICs
- ![alt text](image-329.png)
- ![alt text](image-330.png)
- ![alt text](image-331.png)
- ![alt text](image-332.png)
- ![alt text](image-333.png)
- ASGs can be associated with all vNICs on the VM Device

### Evaluate Effective Security Rules
- ![alt text](image-335.png)

### Implement Azure Bastion
- Microsoft recommends not exposing port 3389 either through RDP or SSH directly to the internet to access a virtual machine.
- As opposed to VPN Gateway or Express Route or RDP or SSH, we can use Azure Bastion
- ![alt text](image-336.png)
- ![alt text](image-337.png)
- Think of Bastion like a DMZ or perimeter network
- Establishes a secure connection to the VM
- Bastion instead of using port 3389 uses port 443 which is meant for HTTPS traffic and hence is more secure.
- ![alt text](image-338.png)
- Bastion allows connection using a web browser.
- Bastion, however does involve a cost aspect.
- ![alt text](image-339.png)
- ![alt text](image-340.png)
- Now we are connected to the VM using a web browser using HTTPS and a very secure connection.
- Bastion connects directly to the VM using the Azure Network and it bypasses the NSGs altogether.
- Hence, no need to expose port 3389.


### Service Endpoint vs Private Endpoint
- A service endpoint allows virtual machines to be able to communicate directly with, storage accounts on the Azure environment without having to go out to the internet and then back in.
- This is what a private endpoint also does :)
- If we have multiple storage accounts and if we enable a service endpoint all of those storage account can interact with the VM directly
- Private endpoint is a 1-1 connection. If we have a private endpoint then only 1 storage account will talk to the VM
- In a private endpoint our subnet will get a vNIC and storage account is linked to the vNIC and it will have a private IP Address.
- ![alt text](image-341.png)
- ![alt text](image-342.png)
- ![alt text](image-343.png)
- ![alt text](image-344.png)

## Configure Name Resolution and Load Balancing
- We can associate a custom domain name with Azure AD
- ![alt text](image-345.png)
- ![alt text](image-346.png)
- ![alt text](image-347.png)
- We can also have DNS names associated with various resources inside our VNETs and Subnets.
- We have a private DNS Zone and public DNS Zone.
- ![alt text](image-348.png)
- ![alt text](image-349.png)
- In Private DNS Zones, we can have domain names registered with various internal Azure resources and these custom domain names work inside Azure only, they dont work in the public internet.
- ![alt text](image-350.png)
- We also have public DNS Zones.
- ![alt text](image-352.png)
- ![alt text](image-353.png)
- ![alt text](image-354.png)
- ![alt text](image-355.png)
- ![alt text](image-356.png)
- ![alt text](image-357.png)
- On-premise network can also connect to the Private DNS Zone
- ![alt text](image-358.png)
- We should already own the DNS Name(purchased through GoDaddy) for the DNS Zones to work. 
- ![alt text](image-359.png)
- If we purchased our DNS Name through GoDaddy.com we need to go to GoDaddy and specify the Name Servers above for our custom domain to work.
- ![alt text](image-360.png)

### Visualizing Azure Load Balancing
- ![alt text](image-361.png)
- Load balancer has health probes that monitor the VMs
- In Layer 7 App GW, we can do URL based load balancing.

### Configuring an internal or public Load Balancer
- ![alt text](image-362.png)
- ![alt text](image-363.png)
- ![alt text](image-364.png)
- ![alt text](image-365.png)
- ![alt text](image-366.png)
- ![alt text](image-367.png)
- ![alt text](image-368.png)
- ![alt text](image-369.png)
- ![alt text](image-370.png)
- ![alt text](image-371.png)
- ![alt text](image-372.png)
- ![alt text](image-373.png)
- ![alt text](image-374.png)
- ![alt text](image-375.png)
- ![alt text](image-376.png)
- ![alt text](image-377.png)
- Using the inbound NAT rule, we can connect to the load balancer public IP and a specific port(say 3389) and then we can connect to VM1 through RDP. It basically looks at the IP-Port combination
- ![alt text](image-378.png)
- ![alt text](image-379.png)

## Creating Azure Application Gateway
- ![alt text](image-380.png)
- ![alt text](image-381.png)
- ![alt text](image-382.png)
- ![alt text](image-383.png)
- Azure App GW will be placed inside its own subnet
- ![alt text](image-384.png)
- ![alt text](image-385.png)
- ![alt text](image-386.png)
- ![alt text](image-387.png)
- ![alt text](image-388.png)
- ![alt text](image-389.png)
- ![alt text](image-390.png)

## Monitor Issues in Azure
- We have Azure Monitor
- ![alt text](image-391.png)
- ![alt text](image-392.png)
- ![alt text](image-393.png)
- Log Analytics Workspace costs money especially when we use it to store metrics from various applications
- ![alt text](image-394.png)
- ![alt text](image-395.png)
- ![alt text](image-396.png)
- ![alt text](image-397.png)
- ![alt text](image-398.png)
- ![alt text](image-399.png)
- ![alt text](image-400.png)
- ![alt text](image-401.png)
- ![alt text](image-402.png)
- ![alt text](image-403.png)
- ![alt text](image-404.png)
- ![alt text](image-405.png)


### Query and Analyze Logs
- We make use of KQL
- ![alt text](image-406.png)

### Setup Alerts and Actions
- ![alt text](image-407.png)
- ![alt text](image-408.png)
- ![alt text](image-409.png)
- ![alt text](image-410.png)
- ![alt text](image-411.png)
- ![alt text](image-412.png)

### VMInsights
- Gives quick glimpse of all of our resources
- ![alt text](image-413.png)
- ![alt text](image-414.png)

### Configure and use Azure Monitor for networks and on-prem connectivity
- ![alt text](image-415.png)
- ![alt text](image-416.png)
- ![alt text](image-417.png)
- ![alt text](image-418.png)

### Azure Network Watcher
- ![alt text](image-419.png)
- It is automatically turned on where we have a virtual network in a region
- 
- Azure Network Watcher is a service provided by Microsoft Azure that enables monitoring, diagnostics, and analytics for Azure virtual networks. It helps users gain insights into network performance and health, troubleshoot issues, and ensure secure and efficient network operations.
- Network Monitoring:
- Topology Visualization: Provides a visual representation of your network resources and their relationships within a virtual network.
- ![alt text](image-420.png)
- ![alt text](image-421.png)
- Connection Monitor: Tracks network connectivity and performance between Azure resources, on-premises systems, or hybrid environments over time. It measures latency, packet loss, and network changes.
- Traffic Analytics: Analyzes network traffic patterns to identify trends, detect anomalies, and optimize network performance using flow logs from Network Security Groups (NSGs).
Diagnostics Tools:
- IP Flow Verify: Checks if a specific traffic flow is allowed or denied based on NSG rules, helping troubleshoot connectivity issues.
- ![alt text](image-422.png)
- Next Hop: Determines the next hop for traffic from a virtual machine (VM) to a destination, aiding in routing issue diagnosis.
- ![alt text](image-424.png)
- Effective Security Rules: Displays the effective NSG rules applied to a VM, simplifying security configuration analysis.
- Packet Capture: Captures network packets to and from VMs for detailed inspection, useful for diagnosing application or security issues.
- VPN Diagnostics: Troubleshoots connectivity issues with Azure VPN Gateway or ExpressRoute by analyzing logs and configurations.
- Performance and Health Insights:
- NSG Flow Logs: Logs information about ingress and egress IP traffic through NSGs, enabling detailed traffic analysis.
- ![alt text](image-423.png)
- Network Performance Monitor: Provides insights into network performance, including latency and packet loss, across Azure and hybrid environments.
- Connection Troubleshooting: Offers automated diagnostics for connectivity issues between Azure resources or external endpoints.
- ![alt text](image-425.png)

### Troubleshooting external networking
- We will use Azure network watcher to troubleshoot external connectivity
- ![alt text](image-426.png)
- ![alt text](image-427.png)
- ![alt text](image-428.png)
- ![alt text](image-429.png)
- ![alt text](image-430.png)

### Troubleshoot Virtual Network Connectivity
- To troubleshoot virtual network connectivity in Azure using Network Watcher, you can leverage its diagnostic tools to identify and resolve issues like blocked traffic, routing problems, or performance bottlenecks.
- Purpose: Captures network packets to analyze traffic for deeper troubleshooting.
Steps:
- Navigate to Network Watcher > Packet Capture.
- Create a new capture by selecting the VM and storage account for saving the capture file.
- Set filters (e.g., protocol, IP, port) to focus on specific traffic.
- Start the capture, reproduce the issue, then download the .pcap file.
- Analyze the file using tools like Wireshark to inspect packet-level details.
- Use Case: Debug application-layer issues or confirm if packets are reaching the destination.
- ![alt text](image-432.png)
- ![alt text](image-433.png)

## Implement Backup and Recovery
### Create an Azure Recovery Services Vault
- ![alt text](image-434.png)
- ![alt text](image-435.png)
- ![alt text](image-436.png)
- ![alt text](image-438.png)
- ![alt text](image-439.png)
- ![alt text](image-440.png)

### Create and configure a backup policy
- ![alt text](image-441.png)
- ![alt text](image-442.png)
- ![alt text](image-443.png)
- ![alt text](image-444.png)

### Doing backup and Restore operations
- ![alt text](image-445.png)
- ![alt text](image-446.png)
- ![alt text](image-447.png)
- We can restore from a snapshot if the file is overridden or lost
- ![alt text](image-448.png)
- ![alt text](image-449.png)
- ![alt text](image-450.png)
- ![alt text](image-451.png)
- ![alt text](image-452.png)
- ![alt text](image-453.png)

### Configuring Azure Site Recovery
- ![alt text](image-454.png)
- ![alt text](image-455.png)
- ![alt text](image-456.png)
- ![alt text](image-457.png)
- ![alt text](image-458.png)
- ![alt text](image-459.png)
- ![alt text](image-460.png)

### Configure and review backup reports
- ![alt text](image-461.png)
- ![alt text](image-462.png)
- ![alt text](image-463.png)
- ![alt text](image-464.png)
- ![alt text](image-465.png)
- ![alt text](image-466.png)
