<%@ page contentType="text/html;charset=UTF-8" %>
					<!-- SHOW -->
					<script type="text/template" id="revocadoTemplateShow">
						
							<div class="numeroMatriculaRow row">
								<label class="col-sm-3 control-label">Número de Matrícula</label>
								<div class="col-sm-4">{{=numeroMatricula}}</div>
							</div>
							
							<div class="nombreCompletoRow row">
								<label class="col-sm-3 control-label">Nombre completo</label>
								<div class="col-sm-4">{{=nombreCompleto}}</div>
							</div>
							<div class="numeroEscrituraRow row">
								<label class="col-sm-3 control-label">Número de escritura a revocar</label>
								<div class="col-sm-4">{{=numeroEscritura}}</div>
								<div class="hidden-xs hidden-sm hidden-md col-lg-offset-2 col-lg-3">
									<div style="text-align:center; margin-top: -0.5em; margin-bottom: -0.5em">
										<button type="button" class="edit btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
										<button type="button" class="delete btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Borrar</button>
									</div>
								</div>
							</div>
							<div class="motivoRow row">
								<label class="col-sm-3 control-label">Motivo</label>
								<div class="col-sm-4">{{=motivo}}</div>
							</div>
							<div class="fechaBajaRow row">
								<label class="col-sm-3 control-label">Fecha de baja</label>
								<div class="col-sm-4">{{=fechaBajaDia}}/{{=fechaBajaMes}}/{{=fechaBajaAnyo}}</div>
							</div>
							<div class="hidden-lg row">
								<div style="text-align:center; margin-top: 0.75em;">
									<button type="button" class="edit btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Editar</button>
									<button type="button" class="delete btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Borrar</button>
								</div>
							</div>
							<input type="hidden" name="revocado" value="{ id:{{=grailsId}}, numeroMatricula:{{=numeroMatricula}}, numeroEscritura:{{=numeroEscritura}}, motivo:'{{=motivo}}', fechaBajaDia:{{=fechaBajaDia}}, fechaBajaMes:{{=fechaBajaMes}}, fechaBajaAnyo:{{=fechaBajaAnyo}} }" />
						
					</script>
					
				  	<!-- EDIT -->
					<script type="text/template" id="revocadoTemplateEdit">
							<div class="msgRevErrorEnCampos alert alert-danger">
								<span class="glyphicon glyphicon-ban-circle"></span> Datos no válidos. Revise los campos marcados en rojo.
							</div>
							
							<div class="numeroMatriculaRow row">
								<label class="col-sm-3 control-label">Número de Matrícula</label>
								<div class="col-sm-4">{{=numeroMatricula}}</div>
							</div>
							<div class="nombreCompletoRow row">
								<label class="col-sm-3 control-label">Nombre completo</label>
								<div class="col-sm-4">{{=nombreCompleto}}</div>
							</div>
							<div class="numeroEscrituraRow row">
								<label class="col-sm-3 control-label">Número de escritura a revocar</label>
								<div class="col-sm-4">
									<input class="numeroEscritura form-control" type="text" value="{{=numeroEscritura}}"/>
								</div>
								<div class="hidden-xs hidden-sm hidden-md col-lg-offset-2 col-lg-3">
									<div style="text-align:center; margin-top: -0.5em; margin-bottom: -0.5em">
										<button type="button" class="update btn btn-primary"><span class="glyphicon glyphicon-ok"></span> Aplicar</button>
										<button type="button" class="cancelEdit btn btn-primary"><span class="glyphicon glyphicon-remove"></span> Cancelar</button>
									</div>
								</div>
							</div>
							<div class="motivoRow row">
								<label class="col-sm-3 control-label">Motivo</label>
								<div class="col-sm-4">
									<textarea class="motivo form-control" rows="3" style="resize:none">{{=motivo}}</textarea>
								</div>
							</div>
							<div class="fechaBajaRow row">
								<label class="col-sm-3 control-label">Fecha de baja</label>
								<div class="col-sm-4">
									<select class="fechaBaja_day form-control"><option value="null">-Seleccione-</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
										<option value="24">24</option>
										<option value="25">25</option>
										<option value="26">26</option>
										<option value="27">27</option>
										<option value="28">28</option>
										<option value="29">29</option>
										<option value="30">30</option>
										<option value="31">31</option>
									</select>
									<select class="fechaBaja_month form-control"><option value="null">-Seleccione-</option>
										<option value="1">enero</option>
										<option value="2">febrero</option>
										<option value="3">marzo</option>
										<option value="4">abril</option>
										<option value="5">mayo</option>
										<option value="6">junio</option>
										<option value="7">julio</option>
										<option value="8">agosto</option>
										<option value="9">septiembre</option>
										<option value="10">octubre</option>
										<option value="11">noviembre</option>
										<option value="12">diciembre</option>
									</select>
									<select class="fechaBaja_year form-control"><option value="null">-Seleccione-</option>
										<option value="2004">2004</option>
										<option value="2005">2005</option>
										<option value="2006">2006</option>
										<option value="2007">2007</option>
										<option value="2008">2008</option>
										<option value="2009">2009</option>
										<option value="2010">2010</option>
										<option value="2011">2011</option>
										<option value="2012">2012</option>
										<option value="2013">2013</option>
										<option value="2014">2014</option>
									</select>
								</div>
							</div>
							<div class="hidden-lg row">
								<div style="text-align:center; margin-top: 0.75em;">
									<button type="button" class="update btn btn-primary"><span class="glyphicon glyphicon-ok"></span> Aplicar</button>
									<button type="button" class="cancelEdit btn btn-primary"><span class="glyphicon glyphicon-remove"></span> Cancelar</button>
								</div>
							</div>

					</script>
					<!-- CREATE -->
					<script type="text/template" id="revocadoTemplateNew">
						
							<div class="msgRevProcesandoDatos alert alert-info">
								<asset:image src="spinner_alert_info.gif"/> <strong>Procesando datos, espere un momento</strong>.
							</div>
							<div class="msgRevMatriculaYaEnLista alert alert-danger">
								<span class="glyphicon glyphicon-ban-circle"></span> Matrícula <strong>ya agregada</strong>.
							</div>
							<div class="msgRevMatriculaNoEncontrada alert alert-danger">
								<span class="glyphicon glyphicon-ban-circle"></span> Matrícula <strong>no encontrada</strong>.
							</div>
							<div class="msgRevErrorEnCampos alert alert-danger">
								<span class="glyphicon glyphicon-ban-circle"></span> Datos no válidos. Revise los campos marcados en rojo.
							</div>
							<div class="msgErrorPeticion" class="alert alert-danger">
								<span class="glyphicon glyphicon-ban-circle"></span> Ha habído un error al procesar la petición.
							</div>
						
							<div class="numeroMatriculaRow row">
								<label class="col-sm-3 control-label">Número de Matrícula</label>
								<div class="col-sm-4"><input class="numeroMatricula form-control" type="text" value=""/></div>
							</div>
							<div class="nombreCompletoRow row">
								<label class="col-sm-3 control-label">Nombre completo</label>
								<div class="col-sm-4"><input class="nombreCompleto form-control" type="text" value="" disabled/></div>
							</div>
							<div class="numeroEscrituraRow row">
								<label class="col-sm-3 control-label">Número de escritura a revocar</label>
								<div class="col-sm-4">
									<input class="numeroEscritura form-control" type="text" value=""/>
								</div>
								<div class="hidden-xs hidden-sm hidden-md col-lg-offset-2 col-lg-3">
									<div style="text-align:center; margin-top: -0.5em; margin-bottom: -0.5em">
										<button type="button" class="save btn btn-primary"><span class="glyphicon glyphicon-ok"></span> Agregar</button>
										<button type="button" class="cancelCreate btn btn-primary"><span class="glyphicon glyphicon-remove"></span> Cancelar</button>
									</div>
								</div>
							</div>
							<div class="motivoRow row">
								<label class="col-sm-3 control-label">Motivo</label>
								<div class="col-sm-4">
									<textarea class="motivo form-control" rows="3" style="resize:none"></textarea>
								</div>
							</div>
							<div class="fechaBajaRow row">
								<label class="col-sm-3 control-label">Fecha de baja</label>
								<div class="col-sm-4">
								
									<select class="fechaBaja_day form-control"><option value="null">-Seleccione-</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
										<option value="24">24</option>
										<option value="25">25</option>
										<option value="26">26</option>
										<option value="27">27</option>
										<option value="28">28</option>
										<option value="29">29</option>
										<option value="30">30</option>
										<option value="31">31</option>
									</select>
									<select class="fechaBaja_month form-control"><option value="null">-Seleccione-</option>
										<option value="1">enero</option>
										<option value="2">febrero</option>
										<option value="3">marzo</option>
										<option value="4">abril</option>
										<option value="5">mayo</option>
										<option value="6">junio</option>
										<option value="7">julio</option>
										<option value="8">agosto</option>
										<option value="9">septiembre</option>
										<option value="10">octubre</option>
										<option value="11">noviembre</option>
										<option value="12">diciembre</option>
									</select>
									<select class="fechaBaja_year form-control"><option value="null">-Seleccione-</option>
										<option value="2004">2004</option>
										<option value="2005">2005</option>
										<option value="2006">2006</option>
										<option value="2007">2007</option>
										<option value="2008">2008</option>
										<option value="2009">2009</option>
										<option value="2010">2010</option>
										<option value="2011">2011</option>
										<option value="2012">2012</option>
										<option value="2013">2013</option>
										<option value="2014">2014</option>
									</select>
								
								</div>
							</div>
							<div class="hidden-lg row">
								<div style="text-align:center; margin-top: 0.75em;">
									<button type="button" class="save btn btn-primary"><span class="glyphicon glyphicon-ok"></span> Agregar</button>
									<button type="button" class="cancelCreate btn btn-primary"><span class="glyphicon glyphicon-remove"></span> Cancelar</button>
								</div>
							</div>

					</script>