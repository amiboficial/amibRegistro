package mx.amib.sistemas.registro.informacion.controller

class SolicitudesController {

	def poderService
	def revocacionService
	
    def index() {
		
		//Dependiendo del usuario en sesión se cargará la lista de pendientes
		def poderInstanceList = poderService.findAllByIdGrupofinanciero(4)
		def revocacionInstanceList = revocacionService.findAllByIdGrupofinanciero(4)
		
		//respond null, model:[poderInstanceList:poderInstanceList]
		render(view: 'index', model:[poderInstanceList:poderInstanceList, revocacionInstanceList:revocacionInstanceList])
	}
	
}
