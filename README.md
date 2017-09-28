# CRUD-pedia
A CRUD application written in Ruby on Rails using test-driven development (TDD).

## Summary

- Ruby: 2.4.0
- Rails: 5.0.4

I wrote the code for this application that allows users to create public and private Markdown-based wikis. This project deepened my understanding of Ruby, Rails (including gems), test-driven development (TDD) as well as Bootstrap. Main features:

- Authentication and authorization
- Email confirmations
- User roles
- Upgrade to paid and downgrade to unpaid membership status
- CRUD operations
- Public/Private wikis
- Collaborator

The deployed version integrates gems from:

- [Devise](https://github.com/plataformatec/devise)
- [Pundit](https://github.com/elabs/pundit)
- [Figaro](https://github.com/laserlemon/figaro)
- [Redcarpet](https://github.com/vmg/redcarpet)
- [Stripe](https://github.com/stripe/stripe-ruby)

The deployed version can be found [here](https://crud-pedia.herokuapp.com).<br>

### Authentication
![login_logout.gif](https://s4.postimg.org/40p91l5a5/login_out.gif "Login and Logout")

### Create wikis
![create_wiki.gif](https://s12.postimg.org/63qfrov4t/create_wiki.gif "Create wikis")

### Upgrade membership
![upgrade.gif](https://s9.postimg.org/faue0mqhb/upgrade.gif "Upgrade membership")

### Create private wiki
![private_wiki.gif](https://s11.postimg.org/h7u1bvclf/private_wiki.gif "Private wiki")

### Granting access to collaborators
![collaborator.gif](https://s1.postimg.org/kiniq14bj/collaborator.gif "Collaborators")
