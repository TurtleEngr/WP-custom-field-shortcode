<?php
/*
 * Plugin Name: Custom Field Shortcode
 * Plugin URI: https://github.com/TurtleEngr/WP-custom-field-shortcode
 * Description: Place custom fields anywhere in your post content.
 * Version: VERSION
 * Author: turtle-engr
 * Author URI: https://github.com/TurtleEngr
 * Text Domain: custom-field-shortcode
 * License: GPLv2
 * License URI: https://www.gnu.org/licenses/gpl-2.0.html
 */

/* Lock out script kiddies: die an direct call */
if (! defined('ABSPATH')) {
    exit;
}

/* Add the shortcode */
function custom_field_shortcode($atts) {
    $atts = shortcode_atts(array(
        'field' => '',
        'post_id' => get_the_ID()
    ), $atts);
    $value = get_post_meta($atts['post_id'], $atts['field'], true);
    return $value ? esc_html($value) : '';
}
add_shortcode('custom_field', 'custom_field_shortcode');

/*
 * Then use it in your post editor:
 * [custom_field field="your_custom_field_name"]
 */
