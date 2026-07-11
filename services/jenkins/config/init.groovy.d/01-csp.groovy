System.setProperty(
  "hudson.model.DirectoryBrowserSupport.CSP",
  "default-src 'self'; img-src 'self' data:; style-src 'self' 'unsafe-inline'; script-src 'self'; object-src 'none'; frame-ancestors 'self'; base-uri 'self';"
)

println "--> Jenkins CSP policy configured from init.groovy.d"