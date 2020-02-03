library(googleway) # Librería de Google que contiene la consulta a Places.
library(readxl)
library(openxlsx)

#Levanto el excel con las sucursales y sus coordenadas
sucursalesxlsx = "C:\\data\\CoordSucursales.xlsx"
CoordSucursales = read_excel(sucursalesxlsx,sheet = "Hoja1", na = "NA")

Places_sucursales = read_excel("C:\\data\\SucursalesPlaces.xlsx", col_types = c("numeric", "text", "text", "text", "numeric", "numeric"))

#Creamos los vectores que se usarán para crear el data frame de salida.
ID_Sucursal=vector();
latitud=vector();
longitud=vector();
Rapipago=vector();
PagoFacil=vector();
ocurrencias=1; #Determinará las filas del Data Frame de salida.

objetivo = "rapipago"
objetivo2 = "pago facil"
radio1 = 400 # Expresado en metros
api_key = "" # Pegar la API Key
Places_sucursales.acum=Places_sucursales

#Con un bucle recorremos las sucursales del data frame CoordSucursales

for (i in 1:dim(CoordSucursales)[1])
{  
  lat=as.numeric(CoordSucursales$lat[i]) #Latitud sucursal i
  long=as.numeric(CoordSucursales$long[i])  #Longitud sucursal i
  
  resultadogoogle1 = google_places(location = ,  name = objetivo, radius = radio1, key = api_key) 
  resultadogoogle2 = google_places(location = c(lat,long), name = objetivo2, radius = radio1, key = api_key)
  
 
      if (resultadogoogle1$status =="ZERO_RESULTS"){ # En caso de que no haya encontrado ninguna coincidencia, el campo Status adopta el valor "Zero_results"
          ID_Sucursal[ocurrencias]= as.numeric(CoordSucursales[i,1]) # En el vector de salida, guardamos el ID de la sucursal en la posicion "ocurrencias"
          latitud[ocurrencias]= as.character(CoordSucursales[i,2]) #Su latitud 
          longitud[ocurrencias]= as.character(CoordSucursales[i,3]) # Y su longitud
          Rapipago[ocurrencias]= 0 # Como no hubo coincidencias, la cantidad de hallazgos es cero.
          ocurrencias=ocurrencias+1 #Pasamos al siguiente registro.
          }else{ #En caso de que haya encontrado resultados:
      ID_Sucursal[ocurrencias]=as.numeric(CoordSucursales[i,1]) #ID de la sucursal
      latitud[ocurrencias]=as.character(CoordSucursales[i,2]) #Su latitud
      longitud[ocurrencias]=as.character(CoordSucursales[i,3]) #Su longitud
      Rapipago[ocurrencias]= dim(resultadogoogle1$results)[1] # En caso de haber encontrado algún local cercano, nos quedamos con la cantidad que encontró (cantidad de filas del data frame).      ocurrencias=ocurrencias+1 #Pasamos al siguiente registro.
          }
    #Resultados de la segunda consulta (en este caso no es necesario volver a guardar el ID, Lat y Long del local, porque ya lo hicimos en la primera)
    if (resultadogoogle2$status =="ZERO_RESULTS"){
      PagoFacil[ocurrencias]= 0
    }else{
      PagoFacil[ocurrencias]= dim(resultadogoogle2$results)[1]
    }
}      

SucursalesPlaces=data.frame(); #Declaramos el Data frame
SucursalesPlaces=cbind(ID_Sucursal,latitud,longitud,Rapipago,PagoFacil2) #Anexamos los vectores para darle contenido.
Places_sucursales=as.data.frame(SucursalesPlaces, stringsAsFactors = FALSE)

Places_sucursales=rbind.data.frame(Places_sucursales.acum,Places_sucursales)

#Exportamos.
write.csv2(Places_sucursales,"C:\\data\\Locales Pagos de Terceros.csv", row.names = FALSE)
