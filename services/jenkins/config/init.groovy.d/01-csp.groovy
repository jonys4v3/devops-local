import jenkins.model.*
import hudson.security.*

String adminUser = System.getenv('JENKINS_ADMIN_ID') ?: 'admin'
String adminPass = System.getenv('JENKINS_ADMIN_PASSWORD') ?: 'Cambiame123456'
String extraUser = System.getenv('JENKINS_EXTRA_ADMIN_ID') ?: 'u01a538c'
String extraPass = System.getenv('JENKINS_EXTRA_ADMIN_PASSWORD') ?: adminPass

def instance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(adminUser, adminPass)
hudsonRealm.createAccount(extraUser, extraPass)
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)
instance.save()
println "Jenkins admin users ensured: ${adminUser}, ${extraUser}"
