canvas-rails-template
=====================
# Setup
1. `cd` to the directory where you keep all of your projects.
2. `git clone git@github.com:jlarusso-canvas/canvas-rails-template.git`
3. `cd canvas-rails-template`
4. Create a new rails app: `rake new`
5. Follow instructions.
6. Go to your project directory: `cd ../sample-app`

# Practices
(to elaborate later)  
- Refer to yard [documentation](http://rubydoc.info/gems/yard/file/docs/GettingStarted.md) for correct documenting practices.
- body class thing
- explain asset directory structure
- asset sync?
- [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)

### TODO
-[] make sure ruby 2.1.2 is installed first
-[] js safety closures issue?
-[] standardize camel case, underscore, whatever for js/ruby and for id/class
-[] prefix 'js-' to classes that have no styles attached and are js only
-[] css
  -[] pages/ are for non-reusable page specific styles
  -[] modules are for 
  -[] componenets are to set default styles for html elements

## Coffeescript naming conventions:
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

## Modular CSS naming conventions:
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
See [John Long's article](http://thesassway.com/advanced/modular-css-naming-conventions) for an in-depth explanation.
