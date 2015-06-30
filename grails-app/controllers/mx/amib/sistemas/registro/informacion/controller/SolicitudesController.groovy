package mx.amib.sistemas.registro.informacion.controller

class SolicitudesController {

	def poderV1Service
	def revocacionV1Service
	
    def index() {
		
		//Dependiendo del usuario en sesión se cargará la lista de pendientes
		def poderInstanceList = poderV1Service.findAllByIdGrupofinanciero(4)
		def revocacionInstanceList = revocacionV1Service.findAllByIdGrupofinanciero(4)
		
		//respond null, model:[poderInstanceList:poderInstanceList]
		render(view: 'index', model:[poderInstanceList:poderInstanceList, revocacionInstanceList:revocacionInstanceList])
	}
	
}
