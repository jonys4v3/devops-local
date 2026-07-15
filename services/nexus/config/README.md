# Configuración Nexus

El contenedor oficial de Nexus usa `/nexus-data` como volumen persistente. Este directorio queda gestionado por Docker Volume desde Terraform.

Este directorio queda como punto de entrada para configuración adicional, por ejemplo:

- Certificados corporativos.
- Scripts de bootstrap vía API REST.
- Plantillas de repositorios.
