#!/bin/bash

VAR="38988471781"

echo $VAR

curl -k -X POST https://sslvas.oi.net.br/OiPlay/ConsultarClienteServicoProxyService -H 'cache-control: no-cache' \
-H 'content-type: application/xml' -H 'postman-token: 983ce95e-68a8-dbc6-cb1e-42081ed52f66' \
-d '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:con="http://www.pti.com.br/vas/ConsultarClienteServicoSOAP/">
<soapenv:Header/>
   <soapenv:Body>
      <con:ConsultarClienteServicoRequest>
         <con:MessageHeader>
            <TransactionId>teste123</TransactionId>
            <Timestamp>2008-09-28T22:49:45</Timestamp>
            <!--Optional:-->
            <Credentials>
               <AppId>OA0841</AppId>
            </Credentials>
         </con:MessageHeader>
         <!--Optional:-->
         <con:Cliente>
            <!--Optional:-->
            <con:IdentidadeLegal>
               <!--Optional:-->
               <con:NumeroDocumentoPrincipal></con:NumeroDocumentoPrincipal>
            </con:IdentidadeLegal>
         </con:Cliente>
         <!--Optional:-->
         <con:Servico>
            <!--Optional:-->
            <con:NumeroServico>'${VAR}'</con:NumeroServico>
            <con:IdSistemaOrigem>AN0448</con:IdSistemaOrigem>
            <!--Optional:-->
            <con:StatusServico>A</con:StatusServico>
         </con:Servico>
         <!--Optional:-->
         <con:ParametrosOperacao>
            <!--Optional:-->
            <con:LimiteMaximoCliente>50</con:LimiteMaximoCliente>
            <!--Optional:-->
            <con:LimiteMaximoServico>50</con:LimiteMaximoServico>
            <!--Optional:-->
            <con:UFSite></con:UFSite>
            <!--Optional:-->
            <con:DDDSite></con:DDDSite>
         </con:ParametrosOperacao>
         <con:GIA_codigoParceiro>oiplay</con:GIA_codigoParceiro>
         <con:GIA_senha>0iplay@2016</con:GIA_senha>
         <con:GIA_codigoServico>233296</con:GIA_codigoServico>
      </con:ConsultarClienteServicoRequest>
   </soapenv:Body>
</soapenv:Envelope>'
