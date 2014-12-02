# mo_server_reverse_proxy_cache-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mo_server_reverse_proxy_cache']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### mo_server_reverse_proxy_cache::default

Include `mo_server_reverse_proxy_cache` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[mo_server_reverse_proxy_cache::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)
