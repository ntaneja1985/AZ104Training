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
