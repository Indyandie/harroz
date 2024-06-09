# wofi

- [sourcehut](https://hg.sr.ht/~scoopta/wofi)
- [styling](https://cloudninja.pw/docs/wofi.html)
- [wofi(7)](https://man.archlinux.org/man/wofi.7.en)
  - `man 7 wofi`

## TO DO

- [ ] window switcher
  - get list of windows and names 
  - pipe to wofi
  - read and store
  - use hyprclt dispatch
- [ ] App Switcher

### template

```sh
ls | wofi --show dmenu | {
read -r id
notify-send $id 
}
```


```sh
hyprctl client -j | jql
hyprctl clients -j | jql '..|>{"class","workspace"}'
```

