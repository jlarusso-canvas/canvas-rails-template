Canvas Rails Project Starter
=====================

# Setup
1. `cd` to the directory where you keep all of your projects.
2. `git clone git@github.com:jlarusso-canvas/canvas-rails-template.git`
3. `cd canvas-rails-template`
4. Create a new rails app: `rake`
5. Follow instructions.
6. Go to your project directory: `cd ../sample-app`


# Documentation
- Refer to [yard](http://rubydoc.info/gems/yard/file/docs/GettingStarted.md) when commenting your ruby code.
- Generate docs with `yard doc` on the command line.


# Practices
#### Page name:
- We want to be able to apply page-specific js and css.
- By default, the body element will be given page-specific class names.
```
# => In app/helpers/application_helper.rb
def page_name
  @page_name || "#{controller_name} #{action_name}"
end

# => In app/views/layouts/application.html.haml
%body{class: "#{page_name}"}
```
- These classes can be overwritten by setting `@page_name` in the relevant controller action.
- `page_name` is also stored as a js variable removing the need for a DOM lookup when doing page-specific js.
```
# => In app/views/layouts/application.html.haml
%script
  var App = App || {};
  App.settings = {
  page: "#{page_name}"
  };
```


#### Modular CSS naming conventions:
See [John Long's article](http://thesassway.com/advanced/modular-css-naming-conventions) for details on modular naming.

- Use dashes for class-names and id-names. No under_scores, no camelCase.

- Think of your CSS in terms of objects.
```
.column { margin: 5px };
```
Not: `.left { margin: 5px };`

- Avoid nesting Parent-Child relationships.
```
.post { margin: 2px }
.post-title { padding-left: 5px; }
```

- Use subclasses for variations on a general object to avoid deep nesting.
```
.button {
  width: 50px;
  background: blue;
}
.button-large {
  @extend .button;
  width: 100px;
}
```

- Prefix modifier names with 'is-'
```
.button {
  background: blue;
  &.is-selected { background: white; }
}
```

- Classes used by js should start with 'js-' and have no associated styles  


#### Ruby style guide:
- [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)


#### Coffeescript naming conventions:
- Variable names are lowercase and underscored  
`item_count = 5`
- Variable names that contain a jQuery object start with a dollar sign  
`$item_elements = $('.item')`
- Instance variables start with an ampersand  
`@item_color = 'red'`
- Instance variables that contain a jQuery object start with a dollar sign after an ampersand  
`@$items $('ul.item-list')`
- Constant names are in all caps and underscored  
`SECRET_KEY = 's@jEafdsjLkfVJsjl;k'`
- Function names areCamelCase  
`doThatThing: (arg) ->`
- Private function names start with an underscore  
`_parseText: (text) ->`
- Class names are capital camel case  
`class ItemManager`


# TODO:
- create `.ruby-version` and `.ruby-gemset` files before bundling.
