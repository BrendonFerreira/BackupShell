Configurando diretórios:

Adicionem no arquivo "dirOrigem.txt" o caminho das pastas a serem bkpeadas, por padrão ele está definido as pastas Origem, Origem2 e Origem3, se quiserem podem deixar assim, mas atenção ao caminho completo, que no caso está o meu nome de usuário.

Configurando crontab:

O Crontab tem que ser configurado como root, então no terminal digite:

sudo crontab -e

aí vocês poderão editar o crontab no nano. Adicionem as seguintes linhas ao fim do arquivo:

#Bkp - Projeto
*/30 * * * * /home/josemarques/UFPR/SO/Projetos/backupDirChoice.sh

~explicando cada parâmetro:
Cada * é um parâmetro, e estão na seguinte ordem:

Minutos | Horas | Dia do Mes | Mes | Dia da Semana

Minutos: de 0 a 59
Horas: de 0  23
Dia mes: de 1 a 31
Mes: de 1 a 12
Dia da seamana: de 0 a 6 OU de 1 a 7 (neste caso, o 0 e o 7 equivalem à domingo)

o * é coringa, ou seja, se colocar * ele vai se repetir sempre.

~explicando a minha configuração

*/30 * * * * /home/josemarques/UFPR/SO/Projetos/backupDirChoice.sh

o comado será executado a qualquer minuto em intervalos de 30 minutos (*/30) em todas as horas, todos os dias do mes, todos os meses, todos os dias da semana.
