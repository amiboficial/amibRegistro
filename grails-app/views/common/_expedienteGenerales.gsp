<%@ page contentType="text/html;charset=UTF-8" %>
			<script type="text/template" id="expedienteDatosGenerales">

				<div class="alert alert-danger validationErrorMessage" style="display: none;">
					Se han detectado errores de entrada en los campos del formulario. Verifique cada campo según corresponda.
					<div class="errorMessagesContainer">
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
						<g:message code="expediente.matricula.label" default="Matrícula" />
					</label>
					<div class="col-md-9 col-sm-9">
						<input type="text" class="form-control numeroMatricula" maxlength="11" value="{{=numeroMatricula}}" disabled=""/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.nombre.label" default="Nombre" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control nombre" maxlength="100" value="{{=nombre}}"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.primerApellido.label" default="Primer apellido" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control primerApellido" maxlength="80" value="{{=primerApellido}}"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.segundoApellido.label" default="Segundo apellido" />
					</label>
		            <div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control segundoApellido" maxlength="80" value="{{=segundoApellido}}"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.fechaNacimiento.label" default="Fecha de nacimiento" />
					</label>
					<div class="col-md-5 col-sm-5">
						<select style="width: 28%;" class="form-control col-md-4 fechaNacimientoDay">
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
						<select style="width: 38%;" class="form-control col-md-4 fechaNacimientoMonth">
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
						<select style="width: 34%;" class="form-control col-md-4 fechaNacimientoYear">
							<option value="-1">-Seleccione-</option>
							<option value="1900">1900</option>
							<option value="1901">1901</option>
							<option value="1902">1902</option>
							<option value="1903">1903</option>
							<option value="1904">1904</option>
							<option value="1905">1905</option>
							<option value="1906">1906</option>
							<option value="1907">1907</option>
							<option value="1908">1908</option>
							<option value="1909">1909</option>
							<option value="1910">1910</option>
							<option value="1911">1911</option>
							<option value="1912">1912</option>
							<option value="1913">1913</option>
							<option value="1914">1914</option>
							<option value="1915">1915</option>
							<option value="1916">1916</option>
							<option value="1917">1917</option>
							<option value="1918">1918</option>
							<option value="1919">1919</option>
							<option value="1920">1920</option>
							<option value="1921">1921</option>
							<option value="1922">1922</option>
							<option value="1923">1923</option>
							<option value="1924">1924</option>
							<option value="1925">1925</option>
							<option value="1926">1926</option>
							<option value="1927">1927</option>
							<option value="1928">1928</option>
							<option value="1929">1929</option>
							<option value="1930">1930</option>
							<option value="1931">1931</option>
							<option value="1932">1932</option>
							<option value="1933">1933</option>
							<option value="1934">1934</option>
							<option value="1935">1935</option>
							<option value="1936">1936</option>
							<option value="1937">1937</option>
							<option value="1938">1938</option>
							<option value="1939">1939</option>
							<option value="1940">1940</option>
							<option value="1941">1941</option>
							<option value="1942">1942</option>
							<option value="1943">1943</option>
							<option value="1944">1944</option>
							<option value="1945">1945</option>
							<option value="1946">1946</option>
							<option value="1947">1947</option>
							<option value="1948">1948</option>
							<option value="1949">1949</option>
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
						</select>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.genero.label" default="Género" />
					</label>
					<div class="col-md-9 col-sm-9">
						<div class="radio">
							<label>
								<input type="radio" name="ZXhwZWRpZW50ZS5nZW5lcm8" class="generoM" value="M" checked>
								Masculino
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="ZXhwZWRpZW50ZS5nZW5lcm8" class="generoF" value="F">
								Femenino
							</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.rfc.label" default="RFC" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control rfc" value="{{=rfc}}" maxlength="13"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.curp.label" default="CURP" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control curp" value="{{=curp}}" maxlength="18"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.correoElectronico.label" default="Correo electrónico" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control correoElectronico" value="{{=correoElectronico}}" maxlength="254"/>
		            </div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.estadoCivil.label" default="Estado Civil" />
					</label>
					<div class="col-md-9 col-sm-9">
						<g:select class="form-control estadoCivil" name='ZXhwZWRpZW50ZS5lc3RhZG9DaXZpbA' 
						noSelection="${['-1':'-Seleccione-']}"
						from='${viewModelInstance?.estadoCivilList}'
						optionKey="id" optionValue="descripcion"></g:select>
		            </div>
				</div>
				
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.nivelEstudios.label" default="Nivel de estudios" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<g:select class="form-control nivelEstudios" name='ZXhwZWRpZW50ZS5uaXZlbEVzdHVkaW9z' 
						noSelection="${['-1':'-Seleccione-']}"
						from='${viewModelInstance?.nivelEstudiosList}'
						optionKey="id" optionValue="descripcion"></g:select>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.nacionalidad.label" default="Nacionalidad" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<g:select class="form-control nacionalidad" name='ZXhwZWRpZW50ZS5uYWNpb25hbGlkYWQ' 
						noSelection="${['-1':'-Seleccione-']}"
						from='${viewModelInstance?.nacionalidadList}'
						optionKey="id" optionValue="descripcion"></g:select>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.calidadMigratoria.label" default="Calidad migratoria" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control calidadMigratoria" value="{{=calidadMigratoria}}"/>
		            </div>
				</div>
				<div class="form-group">
					<label class="col-md-2 col-sm-3 control-label">
		            	<g:message code="expediente.profesion.label" default="Actividad o profesión" />
					</label>
					<div class="col-md-9 col-sm-9">
		            	<input type="text" class="form-control profesion" value="{{=profesion}}"/>
		            </div>
				</div>
							

				<br/>
				
				<div class="form-group">
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
					<div class="col-md-3 col-sm-3">
						<button id="btnSubmit" type="button" class="btn btn-primary btn-block submit">Validar y confirmar datos generales</button>
					</div>
					<div class="col-md-3 col-sm-3">
						<button id="btnCancelEdit" type="button" class="btn btn-primary btn-block edit">Editar datos generales</button>
					</div>
					<div class="col-md-3 col-sm-3">
						&nbsp;
					</div>
				</div>
			</script>