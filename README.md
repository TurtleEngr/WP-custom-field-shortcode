# custom-field-shortcode

![version](https://img.shields.io/badge/version-1.3.2-orange.svg)

![WordPress](https://img.shields.io/badge/WordPress-Compatible-blue.svg)

Using shortcodes, place custom fields anywhere in your post content.

## Installation

Location:
<https://moria.whyayh.com/rel/released/software/own/plugin-custom-field-shortcode/>

1.  Use Add Plugins, upload Plugin custom-field-shortcode-1.3.2.zip
2.  Install and activate the plugin

## How do I use this plugin?

In your post\'s content, look for the custom fields and the bottom of
the post. You can short code with the custom field\'s name. That will be
replaced with the value of the custom field. For example:

> \[custom~field~ field=\"your-custom-field-name\"\]

Replace \"your-custom-field-name\" with one of the custom field name
that are available to the post. To see the custom fields that are
available, select the \"...\" menu option Preferences, section General,
Advanced, turn on \"Custom fields\"

HTML can be put around the \[\] text and multiple \[\] fields can be
added. For example:

> ```{=html}
> <p>
> ```
> \[custom\~field field=\"usp-custom-subtitle\"\]
>
> ```{=html}
> </p>
> ```
> ```{=html}
> <p>
> ```
> by \[custom~field~ field=\"usp-custom-author\"\]
>
> ```{=html}
> </p>
> ```
> ```{=html}
> <p>
> ```
> Link: \[custom~field~ field=\"usp-custom-link\"\]\> \[custom~field~
> field=\"usp-custom-link\"\]
>
> ```{=html}
> </p>
> ```

## How to uninstall the plugin?

Simply deactivate and delete the plugin.
