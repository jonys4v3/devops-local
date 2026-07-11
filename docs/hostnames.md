# Acceso por nombre de servicio

El despliegue configura `hostname` y alias de red Docker para cada servicio:

- `jenkins`
- `gitlab`
- `artifactory`

Dentro de la red Docker los contenedores pueden resolverse entre sí usando esos nombres.

Para que el navegador del equipo anfitrión también resuelva esos nombres, se debe añadir esta línea al archivo `hosts` del sistema:

```text
127.0.0.1 jenkins gitlab artifactory
```

## Linux/macOS

```bash
./scripts/setup_hosts_linux_macos.sh
```

## Windows

Abrir PowerShell como Administrador:

```powershell
./scripts/setup_hosts_windows.ps1
```

## URLs finales

```text
Jenkins:     http://jenkins:8080/
GitLab:      http://gitlab:8929/
Artifactory: http://artifactory:8082/
```
