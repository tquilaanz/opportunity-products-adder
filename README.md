# opportunity-products-adder
<p>
  <a href="https://githubsfdeploy.herokuapp.com/?owner=tquilaanz&repo=opportunity-products-adder">
    <img alt="Deploy to Salesforce" 
    src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png" style="max-width:100%;" />
  </a>
</p>

#This Library
Is contributed by <a href="http://www.tquilaanz.com/">Tquila ANZ team</a>. It is used in lightning experience. When the classic
Salesforce.com is on, opportunity products can be added as a bulk way. However, in lightning experience(winter 17), bulk creating
opportunity products is not available yet. Thus, it is worthwhile to share the Opportunity Products Adder Lightning components so that
bulking creating opportunity products becoming possible in current Lightning experience.

#Steps for set up
(in lightning experience)

1. Go to setup Home
2. Go to Objects and Fields -> Object Manager
3. Find "Opportunity" and click into it.
4. Find Lightning Record Pages and click "New"
5. Choose "Record Page" and click "Next"
6. Select "Header, Subheader, Two Columns" and click "Next"
7. Provide a Lable and in Object choose "Opportunity"
8. Drag the Highlights Panel to the Header section
9. Drag the Sales Path to the Sub Header section
10. Drag the Tabs to the Left Column section
11. Drag the related list to the Right Column section
12. Rename Related tab to be "ACTIVITY" and drag Activities in it
13. Drag Record Detail component in "DETAILS"
14. Add Tab and name it as "Product Adder"
15. Drag OpportunityProductsAdder Component into "PRODUCT ADDER" section
16. Click "Save" and choose "Activate"
17. Check "Active" checkbox and click "Save" 
