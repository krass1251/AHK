makeProjects(projects) {
    Loop, % projects.MaxIndex()
    {
        project := projects[A_Index].name
        if (IsFunc(project)) {
            %project%() ; Вызов функции по имени
        } else {
            Log("Project function " . project . " not found.")
        }
    }
}