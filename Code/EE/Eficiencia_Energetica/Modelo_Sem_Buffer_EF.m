function [PacksA,PacksB]=Modelo_Sem_Buffer_EF(R,ImAr,ImBr)
if (ImAr>=R && ImBr>=R)                                   %(Si los dos enlaces estan disponible)
    PacksA=4;                                       %(El paquete transmitido por A llega a su destino correctamente y es actulazado con un valor de "4" en packsA, "4"=Paquete llega a su destino  )
    PacksB=4;                                        %(El paquete transmitido por B llega a su destino correctamente y es actulazado con un valor de "4" en packsB, "4"=Paquete llega a su destino  )
else                                                                %(Sino si al menos uno de los enlaces no estan disponible)
    PacksA=3;                                        %(El paquete transmitido por A es descartado y su estado es  actulazado con un valor de "3" en packsA,  "3"=Paquete descartado)
    PacksB=3;                                        %(El paquete transmitido por B es descartado y su estado es actulazado con un valor de "3" en packsB,  "3"=Paquete descartado)
end 