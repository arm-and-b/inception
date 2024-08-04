DATA	= $(HOME)/data
COMPOSE	= ./srcs/docker-compose.yml

all:
	@mkdir -p ${DATA}
	@mkdir -p ${DATA}/wordpress ${DATA}/mariadb
	@sudo docker-compose -f ${COMPOSE} up -d --build

stop:
	@sudo docker-compose -f ${COMPOSE} stop

clean: stop
	@sudo docker-compose -f ${COMPOSE} down -v

fclean: clean
	@sudo rm -rf ${DATA}/wordpress ${DATA}/mariadb
	@sudo rm -rf ${DATA}
	@sudo docker system prune -af

re: clean all

.PHONY: all stop clean fclean re
.SILENT: all stop clean fclean re
