package mx.amib.sistemas.registro.legacy.saaec.service

import grails.transaction.Transactional
import groovy.sql.GroovyRowResult
import groovy.sql.Sql

@Transactional
class RegistroExamenService {

    def dataSource_legacySaeec
    static datasource = 'legacySaeec'

    /**
     * Busca en la BD del SAEEC a un registro que haya aprobado su exámen y
     * que no se encuentre ya en registro
     */
    def findRegistrableByNumeroMatricula(Integer numeroMatricula) {
        List<GroovyRowResult> saecRowRegs = null

        //Encuentra el registro en la BD del SAAEC
        Sql sql = new Sql(dataSource_legacySaeec)
        saecRowRegs = sql.rows("SELECT TOP 10 IDE_USUARIO FROM USUARIO U")
        saecRowRegs.each {
            println "Resultado -> " + it.get("IDE_USUARIO")
        }

    }

    /**
     * Busca en la BD del SAEEC a registros que hayan aprobado su exámen y
     * que no se encuentren ya en registro
     */
    def findAllRegistrable(){

    }

}
