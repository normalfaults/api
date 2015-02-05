## How to create ManageIQ Automation Scripts
Jellyfish is utilizing the Service Catalog and Automation capabilities provided by ManageIQ to automate the provisioning of additional cloud services. This guide will walk you through the steps of creating catalog items and automation scripts, and then retrieving the information necessary about a catalog item to interact with jellyfish-core.

####Download and Install ManageIQ
Follow the steps provided here: http://manageiq.org/download/

###Creating an Automation Script
The following steps will guide you through the process of creating an automation method, adding it to a Service Provisioning Template, and then adding them to a Catalog Item. These steps allow them to interact with Jellyfish-UX and Jellyfish-Core. The automation scripts provided are located in in jellyfish-core/app/view/automate. 

####Automation Basics
Here are some general basics to understand the automation scripts provided through jellyfish-core. 

**Global Variables**

The global variable used through ManageIQ to access the options passed through the REST call is:

````
$evm
````
These scripts mainly use the root property and log method of this variable. To access the information passed from the call, use
````
$evm.root['dialog_variable_name]
````
To access the logger, use
````
$evm.root('level', 'message')
````
ManageIQ appends a 'dialog_' to every value passed through the payload that isn't one of their required and standard fields.  

To run the provided scripts, you need the aws (http://aws.amazon.com/sdk-for-ruby/) and rbvmomi (https://github.com/rlane/rbvmomi) ruby gems to be installed on your ManageIQ server. 

For more information regarding automation, such as definitions and additional terminology, please see ManageIQs automation guide: http://manageiq.org/pdf/ManageIQ-0-Lifecycle_and_Automation_Guide-en-US.pdf

####Adding an Automate Method
1. Once logged into ManageIQ, select **Explorer** under the **Automation** menu.
2. From the left side **Datastore** menu, select the Methods class located under Datastore/[your domain]/Service/Provisioning/StateMachines.
3. Select **Add a new instance** from the **Configuration** menu.
4. Enter a name in the **Name** textbox. **Display Name** and **Description** are optional fields.
5. Under the **Value** field next to **execute**, enter the same name from the step above.
6. Click the **Add** button on the bottom right hand corner. 
7. Back on the Methods class page, choose **Methods**.
8. Select **Add a new method** from the configuration menu.
9. Give the method the same name that you created in Step 4.
10. Choose **inline** for the **Location**
11. Paste in a method that has been provided, or one of your own.
12. Click 'Add' from the bottom right hand corner.

####Adding to a Provisioning Template
1. Under the left side **Datastore** menu, select the **ServiceProvision_Template** class.
2. Under the **Configuration** menu, select **Add a new instance**
3. Name your new instance. **Display Name** and **Description** are optional.
4. The template is where you supply the method to be executed for a particular service. The provisioning script will go in the **Value** box of the 'provision' field. Also provided with this template are options for pre and post script execution methods.

####Adding a Catalog Item
1. Select **Catalog** under the **Services** menu.
2. Select **Catalogs** from the left hand side menu.
3. From the configuration menu, select **Add a New Catalog**
4. Add in a **Name** and **Description**.
5. Select **Catalog Items** from the left hand side menu.
6. From the **Configuration** menu, select **Add a New Catalog Item**
7. Input a **Name** and optional **Description**
8. Check the **Display in Dialog** box
9. Choose a the **Catalog** that you previously created, or another one
10. The automation scripts for jellyfish-core are of type **generic**
11. Select whether you'd like to use a **Dialog**
12. Select the **Provisioning Entry Point** to be the Provisioning Template you created under Datastore/[your domain]/Service/Provisioning/StateMachines
13. For **Reconfigure** and **Retirement** entry points, you may select the default. 

####Adding a Dialog
1. Select **Customization** under the **Automation** menu.
2. On the left hand side, select **Service Dialogs**.
3. From the **Configuration** menu, select **Add a new Dialog**
4. **Label** your Dialog and select a **Submit** button. 
5. From the **+** on the top, select **Add a new Tab to this Dialog**
6. Label your tab and add an optional description.
7. From the **+** on the top, select **Add a new Box to this Tab**
8. Label your box and add an optional description
9. From the **+** on the top, select **Add a new Element to this Box**
10. Label and name your boxes. The name of the box is the value that will be passed through to your automation script. Depending on the type of Element that you choose, you will have different options.
11. When complete, select **Save** from the bottom right hand corner. 

###Using the ManageIQ API to retrieve Catalog Item properties
You will need properties Catalog Item properties to configure the use of jellyfish-core and ManageIQ through the UX. These properties that you need can be retrieved using the ManageIQ API as outlined below. The full ManageIQ REST API is available here: http://manageiq.org/documentation/development/rest_api/reference/

####Finding Available Catalog Service Items
To retrieve a list of all available service items, make a request to
````
GET /api/service_templates/
````
The available items are located in the **Resources** array of the response. The 
To retrieve the specific information regarding a specific service item, you can use any one of the "href"s from the "Resources" array. They are all formatted like the following
````
GET /api/service_templates/[catalog_id]
````
The **catalog_id** is what is needed to configure products. This value is the ManageIQ Type ID field on the Edit Products page. 

####Retirement
For the automation methods currently provided in jellyfish-core, each one requires a separate Catalog Item with the appropriate retirement method included. 

