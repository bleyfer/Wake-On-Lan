# Wake On LAN Web Portal 🚀

¡Bienvenido al **Wake On LAN Web Portal**! Esta aplicación web moderna e intuitiva permite a administradores y usuarios gestionar, monitorear y encender equipos de forma remota a través de la red local enviando paquetes mágicos (Magic Packets) de Wake-on-LAN (WOL).

## ✨ Características Principales

*   **⚡ Encendido Remoto (Wake-on-LAN):** Enciende fácilmente computadoras y servidores con un solo clic.
*   **🌍 Multi-idioma (Español / Inglés):** Soporte nativo para múltiples idiomas. La interfaz de usuario, las validaciones de formularios y las notificaciones se adaptan al idioma seleccionado, recordando la preferencia del usuario en una Cookie de forma persistente.
*   **🔍 Escaneo Automático de Red:** Herramienta integrada para escanear y descubrir dispositivos en la red local mediante peticiones ARP/Ping.
*   **👥 Gestión de Usuarios y Permisos:** 
    *   **Panel de Administrador:** Protegido con contraseña, permite gestionar todos los equipos, crear accesos de usuario (PIN) y configurar la red.
    *   **Portal de Usuario:** Acceso simplificado mediante un PIN de 4 dígitos. Cada usuario solo ve y puede encender los equipos que el administrador le haya asignado explícitamente.
*   **📡 Monitoreo de Estado en Tiempo Real:** Visualización en vivo (mediante ping constante) de qué equipos están `Activos` o `Inactivos`, mostrando también el tiempo de respuesta en milisegundos (ms).
*   **🎨 Diseño Moderno "Dark Mode":** Interfaz de usuario elegante, fluida y totalmente responsiva diseñada para un uso cómodo en cualquier dispositivo.

## 📸 Vistazo a la Aplicación

*(Las siguientes imágenes ilustran el funcionamiento del sistema en diferentes vistas y funciones).*

### 1. Inicio de Sesión y Autenticación
![Pantalla de Login](img/1.PNG)
*Pantalla de acceso principal. Permite iniciar sesión como Administrador mediante contraseña maestra, o como Usuario Estándar usando un PIN de 4 dígitos.*

### 2. Panel de Control del Administrador
![Dashboard de Administrador](img/2.PNG)
*Vista central del administrador con monitoreo en tiempo real (ping en milisegundos), edición de equipos y vista del estado online/offline de cada dispositivo registrado.*

### 3. Escáner Automático de Red
![Herramienta de Escaneo](img/3.PNG)
*Funcionalidad para descubrir automáticamente equipos conectados a la red local mediante peticiones Ping/ARP, facilitando su adición al portal.*

### 4. Gestión de Usuarios y Permisos
![Asignación de Usuarios](img/4.PNG)
*Control detallado donde el administrador puede asignar equipos específicos a diferentes usuarios, limitando su acceso solo a lo que necesitan encender.*

### 5. Portal Simplificado para Usuarios
![Vista de Usuario](img/5.PNG)
*Interfaz limpia y directa para los usuarios. Muestra únicamente sus dispositivos asignados con la opción directa de "Encender equipo".*

### 6. Sistema de Validaciones Dinámicas
![Validaciones de Formularios](img/6.PNG)
*Todos los formularios incluyen retroalimentación visual inmediata. Los errores y requerimientos se muestran en el idioma preferido del usuario.*

### 7. Ejecución de Wake-On-LAN
![Notificación WOL](img/7.PNG)
*Notificaciones emergentes que confirman al instante el envío exitoso del Magic Packet hacia el dispositivo objetivo.*

### 8. Administración de Configuraciones de Red
![Configuración de Subredes](img/8.PNG)
*Opciones avanzadas para que el administrador defina subredes específicas y rangos de IP para la función de escaneo automático.*

### 9. Integración Multi-idioma y Preferencias
![Cambio de Idioma](img/9.PNG)
*Selector de idioma y gestión del perfil. La aplicación guarda las preferencias para garantizar una experiencia 100% localizada.*

## 🚀 Guía de Instalación y Uso

### Prerrequisitos
*   Asegúrate de que las computadoras a encender tengan **Wake-on-LAN (WOL)** habilitado en la configuración de la BIOS/UEFI y en las propiedades del adaptador de red del Sistema Operativo.

### Instalación en Windows

1. Descarga el instalador **`Wake On Lan-Setup.exe`** desde la sección de *Releases*.
2. Ejecuta el instalador y sigue los pasos del asistente en pantalla para instalar el portal en tu servidor o equipo Windows. El instalador cuenta con multi-idioma nativo.
3. Una vez instalado, el servicio web iniciará automáticamente en segundo plano. Puedes acceder a la aplicación navegando a `http://localhost:5100` (o el puerto configurado).

### Instalación en Linux / Raspberry Pi (Multiplataforma)

El sistema cuenta con soporte nativo y optimizado para ejecutarse como un servicio (Daemon) en servidores Linux y dispositivos IoT como Raspberry Pi (x64, ARM y ARM64), consultando directamente la tabla ARP del kernel (`/proc/net/arp`) para una perfecta compatibilidad.

1. Descarga el archivo comprimido correspondiente a tu arquitectura (ej. `linux-arm64.zip` para Raspberry Pi OS 64-bits o `linux-x64.zip` para Ubuntu/Debian) desde la sección de *Releases*.
2. Descomprime los archivos en tu servidor (ej. en `/opt/wakeonlan/`). Al ser *Self-Contained*, **no necesitas instalar .NET** en el servidor.
3. Configura un archivo de servicio en `systemd` (`/etc/systemd/system/wakeonlan.service`) para que el sistema inicie de forma persistente.
4. Ejecuta el archivo binario `wakeOnLan` y accede a través de tu navegador.

### Primer Acceso (Administrador)
Al iniciar la aplicación por primera vez, el sistema creará automáticamente su base de datos local con credenciales predeterminadas. La **contraseña de administrador por defecto es `12345678`** (no se requiere usuario). ¡Asegúrate de iniciar sesión y cambiarla inmediatamente desde la configuración de tu perfil para mantener tu red segura!

## 🌍 Soporte Multi-idioma Automático

La aplicación cuenta con soporte completo y dinámico para **Español** e **Inglés**. Todas las interfaces, textos, validaciones de formularios (como longitud de contraseñas y pines requeridos) y notificaciones emergentes se traducen de manera automática al instante.

El idioma puede cambiarse en cualquier momento desde el selector en la esquina inferior izquierda, y el sistema recordará la preferencia de cada dispositivo de forma automática.

## 🛠️ Tecnologías Utilizadas
*   **Framework:** ASP.NET Core 8.0 (Blazor Server)
*   **Base de datos:** SQLite con Entity Framework Core
*   **Seguridad:** Cookie Authentication y Claims

---
*Desarrollado con ❤️ para facilitar la administración remota de hardware.*
