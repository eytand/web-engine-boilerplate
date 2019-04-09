export default class HealthcheckService {
    
	constructor({ loggerFactory }) {
		this.logger = loggerFactory.logger
	}

	/**
     * Implement Healthcheck according to the specific business rules
     */
	check(){
		let returnVal = { status : 'success'}
		this.logger.debug('Healthcheck returns', returnVal)
		return returnVal
	}
}