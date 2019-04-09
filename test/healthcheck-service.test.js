import { expect } from 'chai'
import {initServer} from 'uveye-web-engine'
import request from 'request'
const base = 'http://localhost:1234'

describe('health check service', () => {
	it('test parent healtcheck service based on routing',  done => {
		var { app } = initServer()   
		var srv = app.listen(1234, async () => {
			request.get(`${base}/healthcheck`, (err, res, body) => {
				console.log('Body reponse from healthcheck' ,body)
				expect(res.statusCode).to.equal(200)
				expect(body).to.equal('true')
				srv.close()
				done()
			})
		})
	})
})