# Little Esty Shop

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

This completed "Little Esty Shop" project is a comprehensive e-commerce management system catering to both merchants and administrators: 
  - It provides merchants with a feature-rich dashboard to manage their items, invoices, and customer insights. 
    - Merchants can view their top customers, monitor items ready to ship, and seamlessly update item information, status, and create new items. 
  - Admins, on the other hand, have access to a centralized admin dashboard for overseeing merchant activities, invoices, and top customer statistics. 
    - Admins can efficiently manage merchants by enabling/disabling them, updating merchant details, and creating new merchants. 
    - The system prioritizes revenue tracking, presenting the top 5 merchants/items based on total revenue, and showcasing the best-selling dates. 
    - It ensures smooth order fulfillment by allowing invoice item status updates. 
  - The project offers a user-friendly interface and organized sections for effective management, enhancing the overall e-commerce experience for both merchants and administrators.

## Learning Goals

- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- [Optional] Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements

- Must use Rails 7.0.x, Ruby 3.2.2
- Must use PostgreSQL
- All code must be tested via feature tests and model tests, respectively
- Must use GitHub branching, team code reviews via GitHub PR comments, and either GitHub Projects or a project management tool of your group's choice (Trello, Notion, etc.)
- Must include a thorough README to describe the project
   - README should include a basic description of the project, a summary of the work completed, and some ideas for a potential contributor to work on/refactor next. Also include the names and GitHub links of all student contributors on your project. 
- Must deploy completed code to the internet (using Heroku or Render)
- Continuous Integration / Continuous Deployment is not allowed
- Use of scaffolding is not allowed
- Any gems added to the project must be approved by an instructor
  - Pre-approved gems are `capybara, pry, faker, factory_bot_rails, orderly, simplecov, shoulda-matchers, launchy`

## Setup

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md) 

## DTR

- [Little Esty Shop DTR 9/11/23](https://docs.google.com/document/d/10_gmUGvAQ8LbZBYU3dRThc3mj7Sfw-Kmk0Xc-o0GC5c/edit)

## Project Management Tools

- [Daily Stand-Up miro Board](https://miro.com/app/board/uXjVMmNPycc=/?share_link_id=14014531443)
- [GitHub Project Board](https://github.com/users/ttakahashi1591/projects/1/views/1)
- [Little Esty Shop Presentation Slides](https://docs.google.com/presentation/d/12BDBTXtxbPfRaVe3ooQ-nPHos9hM3-ltIHrdfsFR6cw/edit?usp=sharing)

## Database Schema Chart

![Database Schema Chart](https://user-images.githubusercontent.com/132484941/269422380-816322a4-7064-41d2-a0d0-26497d6aef14.png)


## Authors

- Ethan Bustamante
  - LinkedIn: [Ethan Bustamante](https://www.linkedin.com/in/ethan-bustamante/)
  - GitHub: [ethanb1145](https://github.com/ethanb1145)

- Nicholas Spencer
  - LinkedIn: [Nicholas Spencer ](https://www.linkedin.com/in/nicholas-spencer-fort-collins/)
  - GitHub: [deadbert](https://github.com/deadbert)

- Robert deLaguna
  - LinkedIn: [Robert deLaguna](https://www.linkedin.com/in/robert-delaguna/)
  - GitHub: [rjdelaguna](https://github.com/rjdelaguna)

- Tommy Takahashi
  - LinkedIn: [Tommy Takahashi](https://www.linkedin.com/in/tommy-takahashi/)
  - GitHub: [ttakahashi1591](https://github.com/ttakahashi1591)