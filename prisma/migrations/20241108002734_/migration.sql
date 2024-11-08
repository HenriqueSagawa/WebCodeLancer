/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE `User`;

-- CreateTable
CREATE TABLE `usuarios` (
    `id_usuario` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `senha` VARCHAR(191) NOT NULL,
    `tipo_usuario` ENUM('FREELANCER', 'CLIENTE') NOT NULL,
    `data_criacao` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `status` ENUM('ATIVO', 'INATIVO') NOT NULL,
    `cpf` VARCHAR(20) NOT NULL,
    `nacionalidade` VARCHAR(191) NOT NULL,
    `localizacao` VARCHAR(191) NOT NULL,
    `telefone` INTEGER NOT NULL,
    `foto_perfil` VARCHAR(45) NULL,

    UNIQUE INDEX `usuarios_email_key`(`email`),
    PRIMARY KEY (`id_usuario`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `freelancers` (
    `id_usuario` INTEGER NOT NULL,
    `biografia` TEXT NULL,
    `github` VARCHAR(191) NULL,
    `portfolio` VARCHAR(191) NULL,
    `avaliacao` DOUBLE NULL,

    PRIMARY KEY (`id_usuario`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `clientes` (
    `id_usuario` INTEGER NOT NULL,
    `empresa` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id_usuario`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `habilidades` (
    `id_habilidade` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(100) NOT NULL,
    `descricao` TEXT NULL,

    PRIMARY KEY (`id_habilidade`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `freelancers_habilidades` (
    `freelancers_id_usuario` INTEGER NOT NULL,
    `habilidades_id_habilidade` INTEGER NOT NULL,

    PRIMARY KEY (`freelancers_id_usuario`, `habilidades_id_habilidade`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `projetos` (
    `id_projeto` INTEGER NOT NULL AUTO_INCREMENT,
    `id_usuario` INTEGER NOT NULL,
    `titulo` VARCHAR(191) NOT NULL,
    `descricao` TEXT NULL,
    `data_inicio` DATETIME(3) NOT NULL,
    `data_fim` DATETIME(3) NOT NULL,
    `status` ENUM('ABERTO', 'EM_ANDAMENTO', 'CONCLUIDO', 'CANCELADO') NOT NULL,

    PRIMARY KEY (`id_projeto`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `servicos` (
    `id_servico` INTEGER NOT NULL AUTO_INCREMENT,
    `freelancers_id_usuario` INTEGER NOT NULL,
    `projetos_id_projeto` INTEGER NOT NULL,
    `descricao` TEXT NULL,
    `preco` DECIMAL(10, 2) NOT NULL,

    PRIMARY KEY (`id_servico`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `avaliacoes` (
    `id_avaliacao` INTEGER NOT NULL AUTO_INCREMENT,
    `id_servico` INTEGER NOT NULL,
    `nota` INTEGER NOT NULL,
    `comentario` TEXT NULL,
    `avaliacaoCol` VARCHAR(45) NULL,

    PRIMARY KEY (`id_avaliacao`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_AvaliacaoToUsuario` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_AvaliacaoToUsuario_AB_unique`(`A`, `B`),
    INDEX `_AvaliacaoToUsuario_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `freelancers` ADD CONSTRAINT `freelancers_id_usuario_fkey` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `clientes` ADD CONSTRAINT `clientes_id_usuario_fkey` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `freelancers_habilidades` ADD CONSTRAINT `freelancers_habilidades_freelancers_id_usuario_fkey` FOREIGN KEY (`freelancers_id_usuario`) REFERENCES `freelancers`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `freelancers_habilidades` ADD CONSTRAINT `freelancers_habilidades_habilidades_id_habilidade_fkey` FOREIGN KEY (`habilidades_id_habilidade`) REFERENCES `habilidades`(`id_habilidade`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `projetos` ADD CONSTRAINT `projetos_id_usuario_fkey` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `servicos` ADD CONSTRAINT `servicos_freelancers_id_usuario_fkey` FOREIGN KEY (`freelancers_id_usuario`) REFERENCES `freelancers`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `servicos` ADD CONSTRAINT `servicos_projetos_id_projeto_fkey` FOREIGN KEY (`projetos_id_projeto`) REFERENCES `projetos`(`id_projeto`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `avaliacoes` ADD CONSTRAINT `avaliacoes_id_servico_fkey` FOREIGN KEY (`id_servico`) REFERENCES `servicos`(`id_servico`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_AvaliacaoToUsuario` ADD CONSTRAINT `_AvaliacaoToUsuario_A_fkey` FOREIGN KEY (`A`) REFERENCES `avaliacoes`(`id_avaliacao`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_AvaliacaoToUsuario` ADD CONSTRAINT `_AvaliacaoToUsuario_B_fkey` FOREIGN KEY (`B`) REFERENCES `usuarios`(`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;
