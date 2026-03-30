# ASP.NET Core WebAPI

### stack: [.NET 10, SQL Server, SwaggerUI]

## database

helyezd a `~/Data` mappába a `<database_script_name>.sql` scriptfile-t, és futtasd az `(localdb)\MSSQLLocalDB` serveren.

## packages

a következő csomagokra lesz szükség (`Package Manager Console`):
```shell
Install-Package Microsoft.EntityFrameworkCore
Install-Package Microsoft.EntityFrameworkCore.SqlServer
Install-Package Microsoft.EntityFrameworkCore.Tools
Install-Package Microsoft.VisualStudio.Web.CodeGeneration.Design
Install-Package Swashbuckle.AspNetCore.SwaggerUI
```

## database connection

default connection string beállítása (`appsettings.json`)
```json
...
"ConnectionStrings": {
    "DefaultConnection": "server=(localdb)\\mssqllocaldb;database=<database_name>;"
  },
...
```

## scaffold models and database context

futtasd le a következő utasítást a `Package Manager Console`-ban

```shell
Scaffold-DbContext "Name=ConnectionStrings:DefaultConnection" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -DataAnnotations -Context ApplicationDbContext -ContextDir Data
```

## fix json serialization on navigation properties, and foreign keys in model

ha olyan model-re szeretnél REST API-t írni, ami tartalmaz külső kulcsot és/vagy navigation property-t célszerű lehet ezeket a tulajdonságokat kivenni az API-ból. Ennek módja a következő:

Minden érintett `foreign key`-re és `[InverseProperty("<ModelName>")]` alkalmazd a két következő annotációt:

```csharp
[JsonIgnore]
[ValidateNever]
```

az alábbi két direktíva alkalmazása szükséges a file elején:

```csharp
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
```
**fontos**, hogy a  a `[JsonIgnore]` annotáció **nem** a `Newtonsoft.Json` névtérből, **hanem** a `System.Text.Json.Serialization`-ből jön!

## scaffold API Controllers

`~/Controllers/Api/` mappa környezeti menüjében `Add > New Scaffolded Item >` az 'Add New Scaffolded Item' ablakban válaszd ki a `Common > API > [API Controller with actions, using Entity Framework]`, az 'Add API Controller with actions, using Entity Framework' ablakban válaszd ki a következőket:
- `Model class: ` <- annak a modelnek a neve, amihez a REST action-öket szeretnéd beállítani
- `DbContext class: ` <- az előző lépésben scaffoldolt context osztály (`ApplicationDbContext`)
- `Controller name: ` <- Konvenció szerint Pascal case, model neve többesszámban + Controller (ez az alapértelmezett javaslat)

## ORM service configuration

a `Program.cs`-ben az `// Add services to the container.` sor alá add hozzá a következő kódot:
```csharp
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found");
builder.Services.AddDbContext<ApplicationDbContext>(options => 
    options.UseSqlServer(connectionString));
```
a működéshez szükséges `using` direktívák:

```csharp
using <project_namespace>.Data;
using Microsoft.EntityFrameworkCore;
```

## setup SwaggerUI

> **[2026-03-26 állapot szerint]:** a Visual Studio 2026 már nem támogatja alapértelmezetten a SwaggerUI-t. van egy built-in tool, az Endpoint Explorer, de komoly problémákat tapasztalok vele, és messze nem olyan intuitív. A Swagger re-implementációját vagy valamilyen alternatíva használatát javaslom API tesztre vagy API dokumentáció készítésére: Postman, Scalar vagy Redoc [csak dokumentációhoz]))

A `Program.cs` filban a `//Configure the HTTP request pipeline.` rész egészítsd ki a következőkkel:

```csharp
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/openapi/v1.json", "API v1");
    });
}
```

így a `https://localhost:####/swagger` címen böngészőből elérhető a SwaggerUI felülete, ahol a #### a https kapcsolat portszáma. A port `~/Properties/launchSettings.json` fileban megtekinthető.

Ha szeretnéd, hogy a webalkalmazás Debug módban történő indításkor (`F5` vagy `Ctrl+F5` utasításoknál) egyből böngészőben, a SwaggerUI felülettel nyíljon meg, akkor módosítsd a `~/Properties/launchSettings.json` filet az alábbiak szerint:

- a `"https:"` beállításoknál módosítsd a `"launchBrowser"` tulajdonság értékét `true`-ra.
- adj hozzá egy új tulajdonságot `"launchUrl": "swagger",` névvel és értékkel. (a #### a http és https portszámok eltérőek kell, hogy legyenek) Például:

```json
    "https": {
      "commandName": "Project",
      "dotnetRunMessages": true,
      "launchBrowser": true,
      "launchUrl": "swagger",
      "applicationUrl": "https://localhost:####;http://localhost:####",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    }
```

## fix action-method attributes

> A scaffoldolt action method-ok HTTP verb attribútumai nem tartalmazzák az implicit módon a constaint route paraméterek típusát, ez endpointok Swaggeren való tesztelésénél problémát jelenthet, ezért ezeket kézzel kell javítani a következő három esetben:

| eredeti | módosított |
| :--- |  ---: |
| `[HttpGet("{id}")]` | `[HttpGet("{id:int}")]` |
| `[HttpPut("{id}")]` | `[HttpPut("{id:int}")]` |
| `[HttpDelete("{id}")]` | `[HttpDelete("{id:int}")]` |

> API-ok esetében az implicit típusmeghatározás egyébként is erősen ajánlott, függetlenül attól, hogy milyen eszközt használunk a teszteléshez.