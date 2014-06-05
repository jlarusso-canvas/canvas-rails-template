Canvas Rails Project Starter
=====================

## TODO
- js safety closures issue?
- actual projectreadme should have categories for all the documentation we want in there for a project
- have a little blurb in here about the directory structure for assets
- explain body class thing

## Setup
1. `cd` to the directory where you keep all of your projects.
2. `git clone git@github.com:jlarusso-canvas/canvas-rails-template.git`
3. `cd canvas-rails-template`
4. Create a new rails app: `rake new`
5. Follow instructions.
6. Go to your project directory: `cd ../sample-app`

## Practices

### Modular CSS naming conventions:
- Use dashes for class-names and id-names. No under\_scores, no camelCase.
- Think of your CSS in terms of objects.
```
.button { margin: 5px };
```
- Avoid nesting Parent-Child relationships.
```
.post { margin: 2px }
.post-title { padding-left: 5px; }
```
- Subclass variations on a general object.
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
See [John Long's article](http://thesassway.com/advanced/modular-css-naming-conventions) for an in-depth explanation.

### How to comment your code for documentation purposes
- Refer to [yard](http://rubydoc.info/gems/yard/file/docs/GettingStarted.md).

### Ruby style guide:
- [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)

### Coffeescript naming conventions:
- Variable names are lowercase and underscored  
`item\_count = 5`
- Variable names that contain a jQuery object start with a dollar sign  
`$item\_elements = $('.item')`
- Instance variables start with an ampersand  
`@item\_color = 'red'`
- Instance variables that contain a jQuery object start with a dollar sign after an ampersand  
`@$items $('ul.item-list')`
- Constant names are in all caps and underscored  
`SECRET\_KEY = 's@jEafdsjLkfVJsjl;k'`
- Function names areCamelCase  
`doThatThing: (arg) ->`
- Private function names start with an underscore  
`\_parseText: (text) ->`
- Class names are capital camel case  
`class ItemManager`

