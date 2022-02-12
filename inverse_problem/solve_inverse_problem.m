function S_es = solve_inverse_problem(G,H,in_to_cortex75K_eucl,dipole_numbe,inverse_problem_method)
[ne,ncomponent]= size(H); %ne: number of electrodes

switch char(inverse_problem_method)
    case 'sLORETA'  
        S_es = zeros(dipole_number,ncomponent);
        for ii=1:ncomponent
        [U,s,V] = csvd(G); %singular value decomposition
        s_es_2k = yl_sLORETA(G, U, s, V, H(:,ii), 3); %sLORETA standardized only? what is T?
        s = s_es_2k'*ind2vec(in_to_cortex75K_eucl',size(s_es_2k,1));
        S_es(:,ii) = s/norm(s,2);
        end
    case 'MNE'
        S_es = G'*(G*G'+ 0.001*eye(ne))^(-1)*H;
    end
end