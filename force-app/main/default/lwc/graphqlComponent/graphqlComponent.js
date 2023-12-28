// accountsMinAmount.js
import { LightningElement, wire } from "lwc";
import { gql, graphql } from "lightning/uiGraphQLApi";

export default class graphqlComponent extends LightningElement {
    records;
    errors;

    account;
    contact;
    opportunity;

    Object = "None";

    Objects = [
        { label: "None", value: "None" },
        { label: "Account", value: "Account" },
        { label: "Contact", value: "Contact" },
        { label: "Opportunity", value: "Opportunity" },
    ];

    @wire(graphql, {
        query: gql`
            query AccountWithName {
                uiapi {
                    query {
                        Account (first: 10) {
                            edges {
                                node {
                                    Id
                                    Name {
                                        value
                                    }
                                }
                            }
                        }
                        Contact (first: 10) {
                            edges {
                                node {
                                    Id
                                    Name {
                                        value
                                    }
                                }
                            }
                        }
                        Opportunity (first: 10) {
                            edges {
                                node {
                                    Id
                                    Name {
                                        value
                                    }
                                }
                            }
                        }
                    }
                }
            }`,
    })

    graphqlQueryResult({ data, errors }) {
        this.records = [];
        this.account = [];
        this.contact = [];
        this.opportunity = [];
        if (data) {
            if(this.Object == 'Account'){
                this.account = data.uiapi.query.Account.edges.map((edge) => edge.node);
            }
            else if(this.Object == 'Contact'){
                this.contact = data.uiapi.query.Contact.edges.map((edge) => edge.node);
            }
            else if(this.Object == 'Opportunity'){
                this.opportunity = data.uiapi.query.Opportunity.edges.map((edge) => edge.node);
            }
        }
        this.errors = errors;
    }


    handleObjectChange(event) {
        this.account = [];
        this.contact = [];
        this.opportunity = [];
        this.Object = event.detail.value;
        if(this.Object == 'Account'){
            this.records = this.account
        }
        else if(this.Object == 'Contact'){
            this.records = this.contact
        }
        else if(this.Object == 'Opportunity'){
            this.records = this.opportunity
        }
    }
}