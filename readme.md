# ¿Que es EscalasRhb? 
En el día a día clínico, cada minuto cuenta. Escalas digitaliza la valoración en rehabilitacoón y permite exportar resultados en segundos.

Es una aplicación diseñada para profesionales de la rehabilitación que necesitan acceder de forma rápida, clara y estructurada a herramientas de valoración clínica en su práctica diaria. 

## ¿Que ofrece escalas?

- Acceso rápido a escalas de valoración clínica.
- Cálculo automático de resultados.
- Registro estructurado y claro de cada evaluación. 
- Exportación sencilla de los resultados para integrarlos en informes y documentación clínica. 
- Interfaz limpia y profesional, pensada para el uso diario en consulta. 


# Documentación técnica

## Funcionalidades principales

- Registro de pacientes
- Evaluación mediante escalas clínicas
- Cálculo automático de resultados
- Exportación de informes en PDF
- Envío de feedback desde la app

## Arquitectura 

La aplicación sigue una arquitectura basada en **separación de capas** y el patrón **MVVM (Model–View–ViewModel)**, lo que facilita el mantenimiento, las pruebas y la escalabilidad del código.

La estructura principal es la siguiente:

### Capa de Presentación
Implementada con **SwiftUI**.  
Las vistas (`View`) se comunican con sus respectivos **ViewModels**, que contienen el estado y la lógica de presentación.

### Capa de Dominio
Representada por los **UseCases**, donde reside la lógica de negocio principal de la aplicación.

### Capa de Datos
Compuesta por los **Repositories**, que gestionan el acceso a la persistencia utilizando **SwiftData**.

---

## Lenguaje

- **Swift** (versión moderna compatible con **Swift Concurrency** y **macros**)

---

## Frameworks y tecnologías utilizadas

- **SwiftUI**  
  Framework principal para la interfaz de usuario.

- **SwiftData**  
  Framework moderno para persistencia de datos con entidades y contextos.

- **Testing**  
  Framework de pruebas basado en macros (`@Suite`, `@Test`), siguiendo las mejores prácticas de testing en Swift.

- **Foundation**  
  Utilizado para utilidades básicas de Swift y manipulación de fechas y datos.

- **Environment (SwiftUI)**  
  Utilizado para **inyección de dependencias** y configuración global.

  - **PDF Export (UIGraphicsPDFRenderer)**  
  Utilizado para generar documentos PDF con los resultados de los tests, permitiendo exportar informes de forma rápida y estructurada.

- **MessageUI (MFMailComposeViewController)**  
  Integrado para permitir el envío directo de feedback o soporte desde la aplicación mediante correo electrónico.

---

## Patrones de diseño y buenas prácticas

- **MVVM (Model–View–ViewModel)**  
  Separación clara entre las vistas y la lógica de presentación.

- **Dependency Injection**  
  Uso del `Environment` de SwiftUI para inyectar repositorios y routers, facilitando pruebas y modularidad.

- **Repository Pattern**  
  Encapsula el acceso a la base de datos y desacopla la lógica de negocio de los detalles de persistencia.

- **UseCases**  
  Representan operaciones de dominio, facilitando la reutilización y las pruebas de la lógica de negocio.

- **Navegación desacoplada**  
  Uso de un `NavigationRouter` para gestionar la navegación de forma centralizada y desacoplada de las vistas.

- **Pruebas unitarias y de integración**  
  La aplicación cuenta con suites de pruebas para datos, dominio y presentación, siguiendo un enfoque **TDD-ready**.

---

## Resumen

Este enfoque moderno, utilizando **SwiftUI**, **SwiftData** y patrones de arquitectura ampliamente utilizados, permite construir una aplicación:

- **Robusta**
- **Modular**
- **Escalable**
- **Fácil de mantener**


Para ver la política de privacidad, accede a la pagina https://alvar092.github.io/escalas/