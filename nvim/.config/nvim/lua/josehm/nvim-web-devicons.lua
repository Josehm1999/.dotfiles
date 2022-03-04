local status_ok, webDevicons = pcall(require, "nvim-web-devicons")
if not status_ok then
    return
end



webDevicons.set_icon {
   html = {
    icon = "",
    name = "html"
   },
   css = {
    icon = "",
    name = "css"
   }

}
