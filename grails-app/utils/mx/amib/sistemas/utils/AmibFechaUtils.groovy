package mx.amib.sistemas.utils

import org.apache.commons.lang.time.DateUtils
import java.util.TimeZone

class AmibFechaUtils {
	/**
	 * Obtiene la fecha del sistema, con el timezone seteado a "0"
	 * (util al mandar mensajes por REST)
	 * 
	 * @return
	 */
	public static Date obtenerFechaZ(){
		TimeZone defTZ = TimeZone.getDefault()
		int timeoffset = defTZ.getRawOffset() + defTZ.getDSTSavings()
		Date fechaActual = DateUtils.addMilliseconds(new Date(), timeoffset)
		
		return fechaActual
	}
}
