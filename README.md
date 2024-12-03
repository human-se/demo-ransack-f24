# Searching and Sorting with Ransack

This demonstration shows how to use the [Ransack](https://github.com/activerecord-hackery/ransack#readme) gem to add searching and sorting to the todos index page from the [Pagination with Pagy Demo](https://github.com/human-se/demo-pagy-f24#readme).

If you would like to follow along with the video, clone this repo and switch to the `version-before-demo` branch. The `main` (default) branch holds the solution.

## Video Demo (19 minutes)

[![Screenshot of todos index page with a search form at the top of the page and clickable column headings that sort by column](todo_index_searching_and_sorting.png)](https://youtu.be/OInmcjheFTw?si=C2GNsf6HwQv7jRx0)

- <https://youtu.be/OInmcjheFTw?si=C2GNsf6HwQv7jRx0>

## Steps to Add Searching and Sorting to the Todos Index Page

- **Step 1:** Add `gem 'ransack'` to the `Gemfile` and `bundle install`.

- **Step 2:** In the `TodosController.index` method, instantiate Ransack `Todo` search object, sort the results in ascending order by due date, and retrieve the search results (also apply pagination with Pagy).

```ruby
@q = Todo.ransack(params[:q])
@q.sorts = 'due_date asc' if @q.sorts.empty?
@pagy, @todos = pagy(@q.result(distinct: true), limit: 10)
```

- **Step 3:** In the `index.html.erb` view template, insert the search form above the table of todos.

```erb
<%= search_form_for @q do |f| %>

  <%= f.label :title_cont, class: 'form-label form-label-sm mt-3' %>
  <%= f.search_field :title_cont, class: 'form-control form-control-sm' %>

  <%= f.label :due_date_eq, class: 'form-label  form-label-sm mt-2' %>
  <%= f.search_field :due_date_eq, type: :date, class: 'form-control form-control-sm' %>

  <%= f.submit class: 'btn btn-primary btn-sm my-3' %>
<% end %>
```

- **Step 4:** Also in the `index.html.erb` view template, make the table column heading labels into clickable links that can sort the table by the given column values.

```erb
<th><%= sort_link(@q, :title) %></th>
<th><%= sort_link(@q, :due_date) %></th>
```

- **Step 5:** Add to the `Todo` model class a class method (required by Ransack for security purposes) that returns an array of attributes that Ransack is permitted to make sortable.

```ruby
def self.ransackable_attributes(auth_object = nil)
  %w[title due_date]
end
```

## Further Reading

- [Ransack Homepage](https://github.com/activerecord-hackery/ransack#readme)
- [Ransack Documentation](https://activerecord-hackery.github.io/ransack/)
