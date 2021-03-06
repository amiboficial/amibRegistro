<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/template" id="expedienteDatosRegistro">
	<div class="alert alert-danger validationErrorMessage" style="display: none;">
		Se han detectado errores de entrada en los campos del formulario. Verifique cada campo según corresponda.
		<div class="errorMessagesContainer">
		</div>
	</div>

		<fieldset>
			<legend>Datos de figura</legend>
			
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.figura.label" default="Figura a la que aplicó" />
				</label>
				<div class="col-md-9 col-sm-9">
					<p class="form-control-static">${viewModelInstance?.varianteFiguraInstance?.nombre}</p>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.fechaCertificacion.label" default="Fecha de certificación" />
				</label>
				<div class="col-md-5 col-sm-5">
					<select style="width: 28%;" class="form-control col-md-4 fechaCertificacionDay">
						<option value="-1">-Seleccione-</option>
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
					<select style="width: 38%;" class="form-control col-md-4 fechaCertificacionMonth">
						<option value="-1">-Seleccione-</option>
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
					<select style="width: 34%;" class="form-control col-md-4 fechaCertificacionYear">
						<option value="-1">-Seleccione-</option>
						<option value="1950">1950</option>
						<option value="1951">1951</option>
						<option value="1952">1952</option>
						<option value="1953">1953</option>
						<option value="1954">1954</option>
						<option value="1955">1955</option>
						<option value="1956">1956</option>
						<option value="1957">1957</option>
						<option value="1958">1958</option>
						<option value="1959">1959</option>
						<option value="1960">1960</option>
						<option value="1961">1961</option>
						<option value="1962">1962</option>
						<option value="1963">1963</option>
						<option value="1964">1964</option>
						<option value="1965">1965</option>
						<option value="1966">1966</option>
						<option value="1967">1967</option>
						<option value="1968">1968</option>
						<option value="1969">1969</option>
						<option value="1970">1970</option>
						<option value="1971">1971</option>
						<option value="1972">1972</option>
						<option value="1973">1973</option>
						<option value="1974">1974</option>
						<option value="1975">1975</option>
						<option value="1976">1976</option>
						<option value="1977">1977</option>
						<option value="1978">1978</option>
						<option value="1979">1979</option>
						<option value="1980">1980</option>
						<option value="1981">1981</option>
						<option value="1982">1982</option>
						<option value="1983">1983</option>
						<option value="1984">1984</option>
						<option value="1985">1985</option>
						<option value="1986">1986</option>
						<option value="1987">1987</option>
						<option value="1988">1988</option>
						<option value="1989">1989</option>
						<option value="1990">1990</option>
						<option value="1991">1991</option>
						<option value="1992">1992</option>
						<option value="1993">1993</option>
						<option value="1994">1994</option>
						<option value="1995">1995</option>
						<option value="1996">1996</option>
						<option value="1997">1997</option>
						<option value="1998">1998</option>
						<option value="1999">1999</option>
						<option value="2000">2000</option>
						<option value="2001">2001</option>
						<option value="2002">2002</option>
						<option value="2003">2003</option>
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
						<option value="2015">2015</option>
						<option value="2016">2016</option>
						<option value="2017">2017</option>
						<option value="2018">2018</option>
						<option value="2019">2019</option>
						<option value="2020">2020</option>
						<option value="2021">2021</option>
						<option value="2022">2022</option>
						<option value="2023">2023</option>
						<option value="2024">2024</option>
						<option value="2025">2025</option>
						<option value="2026">2026</option>
						<option value="2027">2027</option>
						<option value="2028">2028</option>
						<option value="2029">2029</option>
						<option value="2030">2030</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.autorizacionSolicitada.label" default="Autorización solicitada" />
				</label>
				<div class="col-md-9 col-sm-9">
					<p class="form-control-static">${viewModelInstance?.varianteFiguraInstance?.figura?.tipoAutorizacion}</p>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.statusEntHistorialInforme.label" default="Informe proporcionado por una sociedad de información crediticia son su historial de cuando menos 5 años" />
				</label>
				<div class="col-md-9 col-sm-9">
					<input type="radio" class="statusEntHistorialInforme" name="statusEntHistorialInforme" value="1">&nbsp;Entregó
					<br/>
					<input type="radio" class="statusEntHistorialInforme" name="statusEntHistorialInforme" value="2">&nbsp;No entregó
					<br/>
					<input type="radio" class="statusEntHistorialInforme" name="statusEntHistorialInforme" value="0" checked>&nbsp;No aplica
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.obsEntHistorialInforme.label" default="(Observaciones)" />
				</label>
				<div class="col-md-9 col-sm-9">
					<input type="text" class="obsEntHistorialInforme form-control"/>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.statusEntCartaRec.label" default="Cartas de Recomendación" />
				</label>
				<div class="col-md-9 col-sm-9">
					<input type="radio" class="statusEntCartaRec" name="statusEntCartaRec" value="1">&nbsp;Entregó
					<br/>
					<input type="radio" class="statusEntCartaRec" name="statusEntCartaRec" value="2">&nbsp;No entregó
					<br/>
					<input type="radio" class="statusEntCartaRec" name="statusEntCartaRec" value="0" checked>&nbsp;No aplica
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.obsEntCartaRec.label" default="(Observaciones)" />
				</label>
				<div class="col-md-9 col-sm-9">
					<input type="text" class="obsEntCartaRec form-control"/>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.statusConstBolVal.label" default="Constancias de las Bolsas de Valores" />
				</label>
				<div class="col-md-9 col-sm-9">
					<input type="radio" class="statusConstBolVal" name="statusConstBolVal" value="1">&nbsp;Entregó
					<br/>
					<input type="radio" class="statusConstBolVal" name="statusConstBolVal" value="2">&nbsp;No entregó
					<br/>
					<input type="radio" class="statusConstBolVal" name="statusConstBolVal" value="0" checked>&nbsp;No aplica
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.obsConstBolVal.label" default="(Observaciones)" />
				</label>
				<div class="col-md-9 col-sm-9">
					<input type="text" class="obsConstBolVal form-control"/>
				</div>
			</div>
			
		</fieldset>
		
		<fieldset>
			<legend>Datos de relación laboral con institución</legend>
			
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.intermediario.label" default="Intermediario del mercado de valores o asesor de inversión contratante en que labora" />
				</label>
				<div class="col-md-9 col-sm-9">
					<g:select class="form-control intermediario" name='aW5zdGl0dWNpb25lcw' 
					noSelection="${['-1':'-Seleccione-']}"
					from='${viewModelInstance?.institucionesList}'
					optionKey="id" optionValue="nombre"></g:select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.fechaLabora.label" default="Fecha a partir de la cual labora" />
				</label>
				<div class="col-md-5 col-sm-5">
					<select style="width: 28%;" class="form-control col-md-4 fechaLaboraDay">
						<option value="-1">-Seleccione-</option>
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
					<select style="width: 38%;" class="form-control col-md-4 fechaLaboraMonth">
						<option value="-1">-Seleccione-</option>
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
					<select style="width: 34%;" class="form-control col-md-4 fechaLaboraYear">
						<option value="-1">-Seleccione-</option>
						<option value="1950">1950</option>
						<option value="1951">1951</option>
						<option value="1952">1952</option>
						<option value="1953">1953</option>
						<option value="1954">1954</option>
						<option value="1955">1955</option>
						<option value="1956">1956</option>
						<option value="1957">1957</option>
						<option value="1958">1958</option>
						<option value="1959">1959</option>
						<option value="1960">1960</option>
						<option value="1961">1961</option>
						<option value="1962">1962</option>
						<option value="1963">1963</option>
						<option value="1964">1964</option>
						<option value="1965">1965</option>
						<option value="1966">1966</option>
						<option value="1967">1967</option>
						<option value="1968">1968</option>
						<option value="1969">1969</option>
						<option value="1970">1970</option>
						<option value="1971">1971</option>
						<option value="1972">1972</option>
						<option value="1973">1973</option>
						<option value="1974">1974</option>
						<option value="1975">1975</option>
						<option value="1976">1976</option>
						<option value="1977">1977</option>
						<option value="1978">1978</option>
						<option value="1979">1979</option>
						<option value="1980">1980</option>
						<option value="1981">1981</option>
						<option value="1982">1982</option>
						<option value="1983">1983</option>
						<option value="1984">1984</option>
						<option value="1985">1985</option>
						<option value="1986">1986</option>
						<option value="1987">1987</option>
						<option value="1988">1988</option>
						<option value="1989">1989</option>
						<option value="1990">1990</option>
						<option value="1991">1991</option>
						<option value="1992">1992</option>
						<option value="1993">1993</option>
						<option value="1994">1994</option>
						<option value="1995">1995</option>
						<option value="1996">1996</option>
						<option value="1997">1997</option>
						<option value="1998">1998</option>
						<option value="1999">1999</option>
						<option value="2000">2000</option>
						<option value="2001">2001</option>
						<option value="2002">2002</option>
						<option value="2003">2003</option>
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
						<option value="2015">2015</option>
						<option value="2016">2016</option>
						<option value="2017">2017</option>
						<option value="2018">2018</option>
						<option value="2019">2019</option>
						<option value="2020">2020</option>
						<option value="2021">2021</option>
						<option value="2022">2022</option>
						<option value="2023">2023</option>
						<option value="2024">2024</option>
						<option value="2025">2025</option>
						<option value="2026">2026</option>
						<option value="2027">2027</option>
						<option value="2028">2028</option>
						<option value="2029">2029</option>
						<option value="2030">2030</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.puestoActual.label" default="Puesto actual" />
				</label>
				<div class="col-md-9 col-sm-9">
					<input type="text" class="form-control puestoActual"/>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.statusEntManifProtesta.label" default="Manifestación ''bajo protesta de decir la verdad'' de acuerdo al formato entregado por AMIB" />
				</label>
				<div class="col-md-9 col-sm-9">
					<input type="radio" class="statusEntManifProtesta" name="statusEntManifProtesta" value="1">&nbsp;Entregó
					<br/>
					<input type="radio" class="statusEntManifProtesta" name="statusEntManifProtesta" value="2">&nbsp;No entregó
					<br/>
					<input type="radio" class="statusEntManifProtesta" name="statusEntManifProtesta" value="0" checked>&nbsp;No aplica
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.obsEntManifProtesta.label" default="(Observaciones)" />
				</label>
				<div class="col-md-9 col-sm-9">
					<input type="text" class="obsEntManifProtesta form-control"/>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.statusEntCartaInter.label" default="Cartas de los intermediarios del mercado de valores o asesores de inversión relativas a su contratación" />
				</label>
				<div class="col-md-9 col-sm-9">
					<input type="radio" class="statusEntCartaInter" name="statusEntCartaInter" value="1">&nbsp;Entregó
					<br/>
					<input type="radio" class="statusEntCartaInter" name="statusEntCartaInter" value="2">&nbsp;No entregó
					<br/>
					<input type="radio" class="statusEntCartaInter" name="statusEntCartaInter" value="0" checked>&nbsp;No aplica
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 col-sm-3 control-label">
					<g:message code="datosRegistro.obsEntCartaInter.label" default="(Observaciones)" />
				</label>
				<div class="col-md-9 col-sm-9">
					<input type="text" class="obsEntCartaInter form-control"/>
				</div>
			</div>
			
		</fieldset>

		<div class="form-group">
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
			<div class="col-md-3 col-sm-3">
				<button id="btnSubmit" type="button" class="submit btn btn-primary btn-block">Validar y confirmar datos de registro</button>
			</div>
			<div class="col-md-3 col-sm-3">
				<button id="btnCancelEdit" type="button" class="edit btn btn-primary btn-block">Editar datos de registro</button>
			</div>
			<div class="col-md-3 col-sm-3">
				&nbsp;
			</div>
		</div>
			
		
		
				
				
</script>