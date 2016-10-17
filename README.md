# opportunity-products-adder
<p>
  <a href="https://githubsfdeploy.herokuapp.com/?owner=tquilaanz&repo=opportunity-products-adder">
    <img alt="Deploy to Salesforce" 
    src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png" style="max-width:100%;" />
  </a>
</p>

#About This Tool
This tool has been developed by the <a href="http://www.tquilaanz.com/">Tquila ANZ team</a>.

The purpose of this tool is to bring the "Add Multiple Products to an Opportunity" functionality of Salesforce Classic to Lightning Experience. Though this will likely be implemented natively by Salesforce at some point in the future, we used this as a learning exercise and thought we'd share the results with everybody. 

Once installed, you can add the Opportunity Product Adder to a Lightning Page to add multiple products to an opportunity, in a wizard style that will be recognisable to Salesforce Classic users. Select a pricebook, search for products and select them, then enter their details before adding them to an Opportunity. 

We hope you find this tool useful, but it is provided "as-is" - we've tested the tool, but can't anticipate every configuration, therefore if you find issues, please feel free to raise an issue.

#Steps for set up
Install the tool using the "Deploy to Salesforce" at the top of this README. Once that's done, the tool can be added to the Opportunity page (instructions assume user is in Lightning Experience)

1. View an Opportunity Record
2. Click on the cog icon in the top right and go to Edit Page
3. Click on the Tabs area in the main component (e.g. where Activity and Chatter reside)
4. On the right hand side, click Add Tab
5. Click on the new Tab row, then set the tab to be Custom, then give the tab a name i.e. Add Products
6. Click on the tab in the main App Builder area
7. Drag the OpportunityProductsAdder component across from the left hand side onto the "Add Component Here" area 
8. Click Save then Activate. Assign the page as necessary.

#Architecture diagram
To help understand how the architecture of the components in this tool, please see the diagram below:
<img alt="Deploy to Salesforce" 
    src="https://tquilaanz.box.com/shared/static/5fqof2t1154v30pfnxkpxamyw3oxpiki.jpeg" style="max-width:100%;" />