import { initServer } from 'web-engine'

var {app, container} = initServer()

app.listen(3000, async () => {
	let { loggerFactory } = container.cradle
	let logger = loggerFactory.logger
	logger.info('Server is up!')
})
